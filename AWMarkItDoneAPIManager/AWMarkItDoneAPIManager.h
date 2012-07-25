//
//  AWMarkItDoneAPIManager.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "AWMarkItDoneAPIManagerDelegate.h"

@interface AWMarkItDoneAPIManager : NSObject

@property(nonatomic, weak) id<AWMarkItDoneAPIManagerDelegate> delegate;
@property(nonatomic, strong) RKObjectManager *objectManager;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *password;

+(AWMarkItDoneAPIManager *)sharedManager;

-(void)authenticate;

@end
