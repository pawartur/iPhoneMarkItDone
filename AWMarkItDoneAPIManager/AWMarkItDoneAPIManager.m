//
//  AWMarkItDoneAPIManager.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWMarkItDoneAPIManager.h"

NSString * const kBaseAPIURLString = @"http://markitdone.dev:8000/";

NSString * const kAuthenticateURLString = @"/accounts/authenticate/";


@implementation AWMarkItDoneAPIManager

@synthesize 
    delegate = _delegate,
    objectManager = _objectManager,
    username = _username,
    password = _password,
    managedObjectContext = _managedObjectContext,
    managedObjectModel = _managedObjectModel,
    persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Class Methods

+(AWMarkItDoneAPIManager *)sharedManager{
    static dispatch_once_t onceToken;
    static AWMarkItDoneAPIManager *manager = nil;
    dispatch_once(&onceToken, ^{
        RKLogConfigureByName("RestKit/Network*", RKLogLevelWarning);
        RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelWarning);
        manager = [[AWMarkItDoneAPIManager alloc] init];
        
        RKObjectManager *objectManager = [RKObjectManager managerWithBaseURLString:kBaseAPIURLString];
        objectManager.objectStore = manager.managedObjectContext.managedObjectStore;
        
        //[objectManager.mappingProvider setMapping:[AWTumblrAPIv2Response mapping] forKeyPath:@""];
        //[objectManager.mappingProvider setErrorMapping:[AWTumblrAPIv2FlatResponse mapping]];
        
        [RKObjectManager setSharedManager:objectManager];
        manager.objectManager = objectManager;
    });
    return manager;
}


#pragma mark - Setters

-(void)setPassword:(NSString *)password{
    _password = password;
    self.objectManager.client.password = password;
}

-(void)setUsername:(NSString *)username{
    _username = username;
    self.objectManager.client.username = username;
}

#pragma mark - API Calls

-(void)authenticate{
    [self.objectManager loadObjectsAtResourcePath:kAuthenticateURLString usingBlock:^(RKObjectLoader *loader){
        loader.onDidLoadResponse = ^(RKResponse *response){
            int statusCode = response.statusCode;
            if (statusCode == 204 && [self.delegate respondsToSelector:@selector(markItDoneAPIManagerDidAuthenticate:)]) {
                [self.delegate markItDoneAPIManagerDidAuthenticate:self];
            }else if (statusCode == 401 && [self.delegate respondsToSelector:@selector(markItDoneAPIManagerDidFailToAuthenticate:)]){
                [self.delegate markItDoneAPIManagerDidFailToAuthenticate:self];
            }
        };
        loader.onDidFailWithError = ^(NSError *error){
            if ([self.delegate respondsToSelector:@selector(markItDoneAPIManagerDidFailWithError:)]) {
                [self.delegate markItDoneAPIManagerDidFailWithError:error];
            }
        };
    }];
}

#pragma mark - Core Data stack
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MarkItDone" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MarkItDone.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
