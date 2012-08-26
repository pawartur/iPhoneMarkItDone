//
//  AWToDoFiltersFetchedResultsTableController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 8/14/12.
//
//

#import "AWToDoFiltersFetchedResultsTableController.h"
#import "AWMarkItDoneAPIManager.h"
#import "AWToDoFilterSectionHeaderView.h"
#import "ToDoList.h"
#import "ToDoContext.h"

typedef enum{
    AWToDoFilersTableViewSectionToDoLists,
    AWToDoFilersTableViewSectionToDoContexts
}AWToDoFilersTableViewSection;

@interface RKAbstractTableController (PullToRefreshEnabled)

- (void)isLoadingDidChange;
- (BOOL)pullToRefreshDataSourceIsLoading:(UIGestureRecognizer *)gesture;
- (void)didStartLoad;
- (void)didFinishLoad;
- (void)didFailLoadWithError:(NSError *)error;
-(void)prepareCellMappings;

@end

@implementation AWToDoFiltersFetchedResultsTableController

@dynamic delegate;

@synthesize
    apiManager = _apiManager,
    toDoListsFetchedResultsController = _toDoListsFetchedResultsController,
    toDoContextsFetchedResultsController = _toDoContextsFetchedResultsController;

-(id)init{
    if (self = [super init]) {
        [self prepareCellMappings];
    }
    return self;
}

#pragma mark - Accessors

-(AWMarkItDoneAPIManager *)apiManager{
    if (!_apiManager) {
        _apiManager = [AWMarkItDoneAPIManager sharedManager];
    }
    return _apiManager;
}

-(NSFetchedResultsController *)toDoListsFetchedResultsController{
    if (!_toDoListsFetchedResultsController) {
        _toDoListsFetchedResultsController = [ToDoList fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil];
        _toDoListsFetchedResultsController.delegate = self;
    }
    return _toDoListsFetchedResultsController;
}

-(NSFetchedResultsController *)toDoContextsFetchedResultsController{
    if (!_toDoContextsFetchedResultsController) {
        _toDoContextsFetchedResultsController = [ToDoContext fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil];
        _toDoContextsFetchedResultsController.delegate = self;
    }
    
    return _toDoContextsFetchedResultsController;
}

#pragma mark - Helpers

- (NSIndexPath *)fetchedResultsIndexPathForIndexPath:(NSIndexPath *)indexPath {
    return [NSIndexPath indexPathForRow:indexPath.row-1 inSection:0];
}

- (NSIndexPath *)indexPathForForFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController andFetchedResultsIndexPath:(NSIndexPath *)indexPath {
    if (fetchedResultsController == self.toDoListsFetchedResultsController) {
        return [NSIndexPath indexPathForRow:indexPath.row+1 inSection:AWToDoFilersTableViewSectionToDoLists];
    }else if(fetchedResultsController == self.toDoContextsFetchedResultsController){
        return [NSIndexPath indexPathForRow:indexPath.row+1 inSection:AWToDoFilersTableViewSectionToDoContexts];
    }
    return nil;
}

-(BOOL)isResetFilterIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == 0;
}

-(BOOL)isAddFilterObjectIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == AWToDoFilersTableViewSectionToDoLists) {
        return indexPath.row == [[self.toDoListsFetchedResultsController fetchedObjects] count] + 1;
    }else if (indexPath.section == AWToDoFilersTableViewSectionToDoContexts){
        return indexPath.row == [[self.toDoContextsFetchedResultsController fetchedObjects] count] + 1;
    }
    return NO;
}

#pragma mark - KVO & Table States

-(BOOL)isLoading{
    return _isLoadingToDoContexts || _isLoadingToDoContexts;
}

- (BOOL)isConsideredEmpty {
    return [[self.toDoListsFetchedResultsController fetchedObjects] count] == [[self.toDoContextsFetchedResultsController fetchedObjects] count] == 0;
}

#pragma mark - Pull To Refresh

- (void)pullToRefreshStateChanged:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        if ([self pullToRefreshDataSourceIsLoading:gesture])
            return;
        AWMarkItDoneAPIManager *apiManager = [AWMarkItDoneAPIManager sharedManager];
        _isLoadingToDoContexts = _isLoadingToDoLists = YES;
        [apiManager loadToDoListsWithCallback:^(NSArray *toDoLists){
            _isLoadingToDoLists = NO;
            if (![self isLoading]) {
                [self isLoadingDidChange];
            }
        }];
        [apiManager LoadToDoContextsWithCallback:^(NSArray *toDoContexts){
            _isLoadingToDoContexts = NO;
            if (![self isLoading]) {
                [self isLoadingDidChange];
            }
        }];
    }
}

#pragma mark - Public

- (void)loadTable {
    [self didStartLoad];
    
    BOOL success;
    NSError *error;
    
    success = [self.toDoListsFetchedResultsController performFetch:&error];
    if (! success) {
        [self didFailLoadWithError:error];
        return;
    }
    
    success = [self.toDoContextsFetchedResultsController performFetch:&error];
    if (! success) {
        [self didFailLoadWithError:error];
        return;
    }
    [self.tableView reloadData];
    [self didFinishLoad];
    
    if ([self isAutoRefreshNeeded] && [self isOnline] && ![self isLoading]) {
        [self performSelector:@selector(loadTableFromNetwork) withObject:nil afterDelay:0];
    }
}

#pragma mark - Managing Sections

- (UITableViewCell *)cellForObjectAtIndexPath:(NSIndexPath *)indexPath {
    id mappableObject = [self objectForRowAtIndexPath:indexPath];
    
    RKTableViewCellMapping* cellMapping = [self.cellMappings cellMappingForObject:mappableObject];
    
    UITableViewCell* cell = [cellMapping mappableObjectForData:self.tableView];
    
    RKObjectMappingOperation* mappingOperation = [[RKObjectMappingOperation alloc] initWithSourceObject:mappableObject destinationObject:cell mapping:cellMapping];
    NSError* error = nil;
    BOOL success = [mappingOperation performMapping:&error];
    
    // NOTE: If there is no mapping work performed, but no error is generated then
    // we consider the operation a success. It is common for table cells to not contain
    // any dynamically mappable content (i.e. header/footer rows, banners, etc.)
    if (success == NO && error != nil) {
        RKLogError(@"Failed to generate table cell for object: %@", error);
        return nil;
    }
    
    return cell;
}

- (NSIndexPath *)indexPathForObject:(id)object {
    if ([object isKindOfClass:[NSManagedObject class]]) {
        NSIndexPath *indexPath;
        NSFetchedResultsController *fetchedResultsController;
        if ([object isKindOfClass:[ToDoList class]]) {
            indexPath = [self.toDoListsFetchedResultsController indexPathForObject:object];
            fetchedResultsController = self.toDoListsFetchedResultsController;
        }else if([object isKindOfClass:[ToDoContext class]]){
            indexPath = [self.toDoContextsFetchedResultsController indexPathForObject:object];
            fetchedResultsController = self.toDoContextsFetchedResultsController;
        }
        if (indexPath) {
            return [self indexPathForForFetchedResultsController:fetchedResultsController andFetchedResultsIndexPath:indexPath];
        }
    }
    return nil;
}

- (UITableViewCell *)cellForObject:(id)object {
    return [self cellForObjectAtIndexPath:[self indexPathForObject:object]];
}

#pragma mark - Table View Delegate and Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView*)theTableView {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat headerHeight = [self tableView:tableView heightForHeaderInSection:section];
    
    AWToDoFilterSectionHeaderView *headerView = [[AWToDoFilterSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 360, headerHeight)];
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    headerView.titleLabel.text = title;
    
    return headerView;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section == AWToDoFilersTableViewSectionToDoLists ? @"ToDo Lists" : @"ToDo Contexts";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id <NSFetchedResultsSectionInfo> sectionInfo;
    if (section == AWToDoFilersTableViewSectionToDoLists) {
        sectionInfo = [[self.toDoListsFetchedResultsController sections] objectAtIndex:0];
    }else{
        sectionInfo = [[self.toDoContextsFetchedResultsController sections] objectAtIndex:0];
    }
    return [sectionInfo numberOfObjects] + 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    RKTableViewCellMapping *cellMapping;
    id mappableObject;
    
    if ([self isResetFilterIndexPath:indexPath]) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"resetFilterCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addCell"];
            cell.textLabel.text = [NSString stringWithFormat:@"All %@", indexPath.section == AWToDoFilersTableViewSectionToDoLists ? @"lists" : @"contexts"];
        }
        return cell;
    }else if ([self isAddFilterObjectIndexPath:indexPath]) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"addFilterObjectCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addCell"];
            cell.textLabel.text = [NSString stringWithFormat:@"Add %@", indexPath.section == AWToDoFilersTableViewSectionToDoLists ? @"list" : @"context"];
        }
        return cell;
    }else{
        mappableObject = [self objectForRowAtIndexPath:indexPath];
        cellMapping = [self.cellMappings cellMappingForObject:mappableObject];
        cell = [cellMapping mappableObjectForData:self.tableView];
        
        RKObjectMappingOperation* mappingOperation = [[RKObjectMappingOperation alloc] initWithSourceObject:mappableObject destinationObject:cell mapping:cellMapping];
        NSError* error = nil;
        [mappingOperation performMapping:&error];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(tableController:didSelectToDoFilter:)]) {
        [self.delegate tableController:self didSelectToDoFilter:[self objectForRowAtIndexPath:indexPath]];
    }
}

#pragma mark - Cell Mappings

-(void)prepareCellMappings{
    RKTableViewCellMapping *cellMapping = [RKTableViewCellMapping cellMapping];
    cellMapping.cellClassName = @"UITableViewCell";
    cellMapping.reuseIdentifier = @"ToDoFilterCell";
    [cellMapping mapKeyPath:@"name" toAttribute:@"textLabel.text"];
    
    [self.cellMappings setCellMapping:cellMapping forClass:[ToDoList class]];
    [self.cellMappings setCellMapping:cellMapping forClass:[ToDoContext class]];
}

- (id)objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isAddFilterObjectIndexPath:indexPath] || [self isResetFilterIndexPath:indexPath]) {
        return nil;
    }

    if (indexPath.section == AWToDoFilersTableViewSectionToDoLists) {
        return [self.toDoListsFetchedResultsController objectAtIndexPath:[self fetchedResultsIndexPathForIndexPath:indexPath]];
    }else if(indexPath.section == AWToDoFilersTableViewSectionToDoContexts){
        return [self.toDoContextsFetchedResultsController objectAtIndexPath:[self fetchedResultsIndexPathForIndexPath:indexPath]];
    }
    return nil;
}

#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller {   
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController*)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    
    if (controller == self.toDoListsFetchedResultsController) {
        sectionIndex = AWToDoFilersTableViewSectionToDoLists;
    }else if(controller == self.toDoContextsFetchedResultsController){
        sectionIndex = AWToDoFilersTableViewSectionToDoContexts;
    }
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController*)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    NSIndexPath* adjIndexPath = [self indexPathForForFetchedResultsController:controller andFetchedResultsIndexPath:indexPath];
    NSIndexPath* adjNewIndexPath = [self indexPathForForFetchedResultsController:controller andFetchedResultsIndexPath:newIndexPath];

    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:adjNewIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:adjIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[adjIndexPath] withRowAnimation:UITableViewRowAnimationTop];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:adjIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:adjNewIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            RKLogTrace(@"Encountered unexpected object changeType: %d", type);
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller {
    [self.tableView endUpdates];
    [self didFinishLoad];
}


@end
