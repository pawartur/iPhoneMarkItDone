//
//  ToDoContext.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/29/12.
//
//

#import "ToDoContext.h"
#import "ToDo.h"


@implementation ToDoContext

@dynamic name;
@dynamic toDoContextId;
@dynamic toDos;

+(RKManagedObjectMapping *)mappingInManagedObjectStore:(RKManagedObjectStore *)objectStore{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:self inManagedObjectStore:objectStore];
    
    [mapping mapKeyPath:@"id" toAttribute:@"toDoContextId"];
    [mapping mapKeyPath:@"name" toAttribute:@"name"];
       
    return mapping;
}

@end
