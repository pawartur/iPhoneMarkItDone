//
//  AWMarkItDoneAPIManagerDelegate.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AWMarkItDoneAPIManager;

@protocol AWMarkItDoneAPIManagerDelegate <NSObject>

-(void)markItDoneAPIManagerDidAuthenticate:(AWMarkItDoneAPIManager *)manager;
-(void)markItDoneAPIManager:(AWMarkItDoneAPIManager *)manager didFailWithError:(NSError *)error;

@end
