//
//  AWToDoFiltersFetchedResultsTableController.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 8/14/12.
//
//

#import <RestKit/RestKit.h>

@interface AWToDoFiltersFetchedResultsTableController : RKFetchedResultsTableController{
    BOOL isLoadingToDoLists;
    BOOL isLoadingToDoContexts;
}

@end

@interface RKFetchedResultsTableController (PullToRefreshEnabled)

- (void)isLoadingDidChange;

@end
