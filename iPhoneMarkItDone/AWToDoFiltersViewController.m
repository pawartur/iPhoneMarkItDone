//
//  AWToDoFiltersViewController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 8/7/12.
//
//

#import "MFSideMenu.h"
#import "AWToDoFiltersViewController.h"
#import "AWToDoFiltersFetchedResultsTableController.h"
#import "AWMarkItDoneAPIManager.h"
#import "ToDoList.h"

@interface AWToDoFiltersViewController ()

@property(nonatomic, retain) AWMarkItDoneAPIManager *apiManager;
@property(nonatomic, retain) AWToDoFiltersFetchedResultsTableController *tableController;

@end

@implementation AWToDoFiltersViewController

@synthesize
    tableController = _tableController,
    apiManager = _apiManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableController = [self.apiManager fetchedResultsTableControllerForToFoFiltersViewController:self];
    
    [self.apiManager loadToDoListsWithCallback:nil];
    [self.apiManager LoadToDoContextsWithCallback:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableController loadTable];
}

#pragma mark - Accessors

-(AWMarkItDoneAPIManager *)apiManager{
    if (!_apiManager) {
        _apiManager = [AWMarkItDoneAPIManager sharedManager];
    }
    return _apiManager;
}

@end
