//
//  AWToDoFiltersFetchedResultsTableControllerDelegate.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 8/25/12.
//
//

#import <Foundation/Foundation.h>

@class AWToDoFiltersFetchedResultsTableController;

@protocol AWToDoFiltersFetchedResultsTableControllerDelegate <NSObject>

-(void)tableController:(AWToDoFiltersFetchedResultsTableController *)tableController didSelectToDoFilter:(id)toDoFilter;

@end
