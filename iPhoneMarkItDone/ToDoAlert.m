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
@dynamic objectId;
@dynamic toDo;

+(RKManagedObjectMapping *)mappingInManagedObjectStore:(RKManagedObjectStore *)objectStore{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:self inManagedObjectStore:objectStore];
    
    [mapping mapKeyPath:@"id" toAttribute:@"objectId"];
    [mapping mapKeyPath:@"time" toAttribute:@"time"];
    
    //[mapping mapKeyPath:@"todo_id" toRelationship:@"toDo" withMapping:[ToDo mappingInManagedObjectStore:objectStore]];
    
    mapping.primaryKeyAttribute = @"objectId";
    
    return mapping;
}

@end
