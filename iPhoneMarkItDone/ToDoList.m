//
//  ToDoList.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/29/12.
//
//

#import "ToDoList.h"
#import "ToDo.h"


@implementation ToDoList

@dynamic name;
@dynamic objectId;
@dynamic toDos;

+(RKManagedObjectMapping *)mappingInManagedObjectStore:(RKManagedObjectStore *)objectStore{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:self inManagedObjectStore:objectStore];
    
    [mapping mapKeyPath:@"id" toAttribute:@"objectId"];
    [mapping mapKeyPath:@"name" toAttribute:@"name"];
    
    mapping.primaryKeyAttribute = @"objectId";
    
    return mapping;
}

@end
