//
//  ToDoList.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/29/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ToDoList : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *toDos;
@end

@interface ToDoList (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inToDosAtIndex:(NSUInteger)idx;
- (void)removeObjectFromToDosAtIndex:(NSUInteger)idx;
- (void)insertToDos:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeToDosAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInToDosAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceToDosAtIndexes:(NSIndexSet *)indexes withToDos:(NSArray *)values;
- (void)addToDosObject:(NSManagedObject *)value;
- (void)removeToDosObject:(NSManagedObject *)value;
- (void)addToDos:(NSOrderedSet *)values;
- (void)removeToDos:(NSOrderedSet *)values;
@end
