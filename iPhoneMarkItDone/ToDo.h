//
//  ToDo.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/29/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ToDoAlert, ToDoContext, ToDoList;

@interface ToDo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * creationTime;
@property (nonatomic, retain) NSDate * lastUpdateTime;
@property (nonatomic, retain) NSDate * dueTime;
@property (nonatomic, retain) NSDate * completionTime;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSNumber * toDoId;
@property (nonatomic, retain) ToDoList *toDoList;
@property (nonatomic, retain) ToDoContext *toDoContext;
@property (nonatomic, retain) NSOrderedSet *toDoAlerts;

+(RKManagedObjectMapping *)mappingInManagedObjectStore:(RKManagedObjectStore *)objectStore;

@end

@interface ToDo (CoreDataGeneratedAccessors)

- (void)insertObject:(ToDoAlert *)value inToDoAlertsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromToDoAlertsAtIndex:(NSUInteger)idx;
- (void)insertToDoAlerts:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeToDoAlertsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInToDoAlertsAtIndex:(NSUInteger)idx withObject:(ToDoAlert *)value;
- (void)replaceToDoAlertsAtIndexes:(NSIndexSet *)indexes withToDoAlerts:(NSArray *)values;
- (void)addToDoAlertsObject:(ToDoAlert *)value;
- (void)removeToDoAlertsObject:(ToDoAlert *)value;
- (void)addToDoAlerts:(NSOrderedSet *)values;
- (void)removeToDoAlerts:(NSOrderedSet *)values;
@end
