//
//  ToDo.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/29/12.
//
//

#import "ToDo.h"
#import "ToDoAlert.h"
#import "ToDoContext.h"
#import "ToDoList.h"


@implementation ToDo

@dynamic name;
@dynamic notes;
@dynamic creationTime;
@dynamic lastUpdateTime;
@dynamic dueTime;
@dynamic completionTime;
@dynamic priority;
@dynamic toDoId;
@dynamic toDoList;
@dynamic toDoContext;
@dynamic toDoAlerts;

+(RKManagedObjectMapping *)mappingInManagedObjectStore:(RKManagedObjectStore *)objectStore{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:self inManagedObjectStore:objectStore];
    
    [mapping mapKeyPath:@"id" toAttribute:@"toDoId"];
    [mapping mapKeyPath:@"name" toAttribute:@"name"];
    [mapping mapKeyPath:@"creation_time" toAttribute:@"creationTime"];
    [mapping mapKeyPath:@"last_update_time" toAttribute:@"lastUpdateTime"];
    [mapping mapKeyPath:@"due_time" toAttribute:@"dueTime"];
    [mapping mapKeyPath:@"completion_time" toAttribute:@"completionTime"];
    [mapping mapKeyPath:@"priority" toAttribute:@"priority"];
    
    [mapping mapKeyPath:@"todo_list" toRelationship:@"toDoList" withMapping:[ToDoList mappingInManagedObjectStore:objectStore]];
    [mapping mapKeyPath:@"todo_context" toRelationship:@"toDoContext" withMapping:[ToDoContext mappingInManagedObjectStore:objectStore]];
    [mapping mapKeyPath:@"todo_alerts" toRelationship:@"toDoAlerts" withMapping:[ToDoAlert mappingInManagedObjectStore:objectStore]];
    
    mapping.rootKeyPath = @"object_list";
    
    mapping.primaryKeyAttribute = @"toDoId";
    return mapping;
}

@end
