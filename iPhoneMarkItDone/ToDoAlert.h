//
//  ToDoAlert.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/29/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ToDoAlert : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSManagedObject *toDo;

@end
