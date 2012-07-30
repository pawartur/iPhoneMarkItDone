//
//  ToDoAlert.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/29/12.
//
//

#import "ToDoAlert.h"
#import "ToDo.h"


@implementation ToDoAlert

@dynamic time;
@dynamic toDoAlertId;
@dynamic toDo;

+(RKManagedObjectMapping *)mappingInManagedObjectStore:(RKManagedObjectStore *)objectStore{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:self inManagedObjectStore:objectStore];
    
    [mapping mapKeyPath:@"id" toAttribute:@"toDoAlertId"];
    [mapping mapKeyPath:@"time" toAttribute:@"time"];
    
    [mapping mapKeyPath:@"todo_id" toRelationship:@"toDo" withMapping:[ToDo mappingInManagedObjectStore:objectStore]];
    
    return mapping;
}

@end
