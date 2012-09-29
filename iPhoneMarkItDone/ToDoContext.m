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
@dynamic type;
@dynamic objectId;
@dynamic toDos;

+ (RKManagedObjectMapping *)mappingInManagedObjectStore:(RKManagedObjectStore *)objectStore
{
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:self inManagedObjectStore:objectStore];
    
    [mapping mapKeyPath:@"id" toAttribute:@"objectId"];
    [mapping mapKeyPath:@"name" toAttribute:@"name"];
    
    mapping.primaryKeyAttribute = @"objectId";
    
    mapping.rootKeyPath = @"object_list";
    
    return mapping;
}

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    [self setValue:@"ToDo Context" forKey:@"type"];
}

@end
