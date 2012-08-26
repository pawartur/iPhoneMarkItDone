//
//  AWToDoFiltersViewControllerDelegate.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 8/26/12.
//
//

#import <Foundation/Foundation.h>

@class AWToDoFiltersViewController;

@protocol AWToDoFiltersViewControllerDelegate <NSObject>

-(void)viewController:(AWToDoFiltersViewController *)viewController didSelectToDoFilter:(id)toDoFilter;

@end
