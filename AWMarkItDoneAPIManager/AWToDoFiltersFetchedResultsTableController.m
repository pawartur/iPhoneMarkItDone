//
//  AWToDoFiltersFetchedResultsTableController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 8/14/12.
//
//

#import "AWToDoFiltersFetchedResultsTableController.h"
#import "AWMarkItDoneAPIManager.h"

@implementation AWToDoFiltersFetchedResultsTableController

- (BOOL)pullToRefreshDataSourceIsLoading:(UIGestureRecognizer *)gesture {
    // If we have already been loaded and we are loading again, a refresh is taking place...
    return [self isLoaded] && [self isLoading] && [self isOnline];
}

- (void)pullToRefreshStateChanged:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        if ([self pullToRefreshDataSourceIsLoading:gesture])
            return;
        AWMarkItDoneAPIManager *apiManager = [AWMarkItDoneAPIManager sharedManager];
        [apiManager loadToDoLists];
        [apiManager LoadToDoContexts];
    }
}

@end
