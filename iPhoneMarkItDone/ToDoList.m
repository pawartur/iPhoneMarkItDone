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
@dynamic toDoListId;
@dynamic toDos;

+(RKManagedObjectMapping *)mappingInManagedObjectStore:(RKManagedObjectStore *)objectStore{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:self inManagedObjectStore:objectStore];
    
    [mapping mapKeyPath:@"id" toAttribute:@"toDoListId"];
    [mapping mapKeyPath:@"name" toAttribute:@"name"];
    
    return mapping;
}

@end
