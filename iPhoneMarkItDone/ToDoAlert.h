//
//  ToDoAlert.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/29/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ToDo;

@interface ToDoAlert : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSNumber * toDoAlertId;
@property (nonatomic, retain) ToDo *toDo;

@end
