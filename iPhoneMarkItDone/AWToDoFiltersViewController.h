//
//  AWToDoFiltersViewController.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 8/7/12.
//
//

#import <UIKit/UIKit.h>
#import "AWToDoFiltersFetchedResultsTableControllerDelegate.h"
#import "AWToDoFiltersViewControllerDelegate.h"

@interface AWToDoFiltersViewController : UITableViewController <AWToDoFiltersFetchedResultsTableControllerDelegate>

@property(nonatomic, weak)id<AWToDoFiltersViewControllerDelegate> delegate;

@end
