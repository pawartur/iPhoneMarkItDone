//
//  AWMarkItDoneAPIManager.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWToDoListFetchedResultsTableController.h"
#import "AWToDoFiltersFetchedResultsTableController.h"
#import "AWMarkItDoneAPIManagerDelegate.h"
#import "AWToDoListViewController.h"
#import "AWToDoFiltersViewController.h"

@interface AWMarkItDoneAPIManager : NSObject

@property(nonatomic, weak) id<AWMarkItDoneAPIManagerDelegate> delegate;
@property(nonatomic, strong) RKObjectManager *objectManager;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *password;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(AWMarkItDoneAPIManager *)sharedManager;

-(void)authenticate;
-(void)loadToDoLists;
-(void)LoadToDoContexts;

-(AWToDoListFetchedResultsTableController *)fetchedResultsTableControllerForToDoListViewController:(AWTodoListViewController *)viewController;
-(AWToDoFiltersFetchedResultsTableController *)fetchedResultsTableControllerForToFoFiltersViewController:(AWToDoFiltersViewController *)viewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
