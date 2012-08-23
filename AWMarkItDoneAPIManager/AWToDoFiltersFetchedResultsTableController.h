//
//  AWToDoFiltersFetchedResultsTableController.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 8/14/12.
//
//

#import <RestKit/RestKit.h>

@class AWMarkItDoneAPIManager;

@interface AWToDoFiltersFetchedResultsTableController : RKAbstractTableController <NSFetchedResultsControllerDelegate>{
    BOOL _isLoadingToDoLists;
    BOOL _isLoadingToDoContexts;
}

@property(nonatomic, strong) AWMarkItDoneAPIManager *apiManager;
@property(nonatomic, strong) NSFetchedResultsController *toDoListsFetchedResultsController;
@property(nonatomic, strong) NSFetchedResultsController *toDoContextsFetchedResultsController;

- (void)loadTable;

@end
