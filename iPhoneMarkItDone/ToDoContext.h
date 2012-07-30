//
//  ToDoContext.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/29/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ToDo;

@interface ToDoContext : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * toDoContextId;
@property (nonatomic, retain) NSOrderedSet *toDos;

+(RKManagedObjectMapping *)mappingInManagedObjectStore:(RKManagedObjectStore *)objectStore;

@end

@interface ToDoContext (CoreDataGeneratedAccessors)

- (void)insertObject:(ToDo *)value inToDosAtIndex:(NSUInteger)idx;
- (void)removeObjectFromToDosAtIndex:(NSUInteger)idx;
- (void)insertToDos:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeToDosAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInToDosAtIndex:(NSUInteger)idx withObject:(ToDo *)value;
- (void)replaceToDosAtIndexes:(NSIndexSet *)indexes withToDos:(NSArray *)values;
- (void)addToDosObject:(ToDo *)value;
- (void)removeToDosObject:(ToDo *)value;
- (void)addToDos:(NSOrderedSet *)values;
- (void)removeToDos:(NSOrderedSet *)values;
@end
