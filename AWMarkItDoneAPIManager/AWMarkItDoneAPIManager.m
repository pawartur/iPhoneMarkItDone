//
//  AWMarkItDoneAPIManager.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWMarkItDoneAPIManager.h"

NSString * const kBaseAPIURLString = @"http://markitdone.dev:8000/";

NSString * const kAuthenticateURLString = @"/accounts/authenticate/";


@implementation AWMarkItDoneAPIManager

@synthesize 
    delegate = _delegate,
    objectManager = _objectManager,
    username = _username,
    password = _password;

#pragma mark - Class Methods

+(AWMarkItDoneAPIManager *)sharedManager{
    static dispatch_once_t onceToken;
    static AWMarkItDoneAPIManager *manager = nil;
    dispatch_once(&onceToken, ^{
        RKLogConfigureByName("RestKit/Network*", RKLogLevelWarning);
        RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelWarning);
        manager = [[AWMarkItDoneAPIManager alloc] init];
        
        RKObjectManager *objectManager = [RKObjectManager managerWithBaseURLString:kBaseAPIURLString];
        
        //[objectManager.mappingProvider setMapping:[AWTumblrAPIv2Response mapping] forKeyPath:@""];
        //[objectManager.mappingProvider setErrorMapping:[AWTumblrAPIv2FlatResponse mapping]];
        
        [RKObjectManager setSharedManager:objectManager];
        manager.objectManager = objectManager;
    });
    return manager;
}

#pragma mark - Setters

-(void)setPassword:(NSString *)password{
    _password = password;
    self.objectManager.client.password = password;
}

-(void)setUsername:(NSString *)username{
    _username = username;
    self.objectManager.client.username = username;
}

#pragma mark - API Calls

-(void)authenticate{
    [self.objectManager loadObjectsAtResourcePath:kAuthenticateURLString usingBlock:^(RKObjectLoader *loader){
        loader.onDidLoadResponse = ^(RKResponse *response){
            int statusCode = response.statusCode;
            if (statusCode == 204 && [self.delegate respondsToSelector:@selector(markItDoneAPIManagerDidAuthenticate:)]) {
                [self.delegate markItDoneAPIManagerDidAuthenticate:self];
            }else if (statusCode == 401 && [self.delegate respondsToSelector:@selector(markItDoneAPIManagerDidFailToAuthenticate:)]){
                [self.delegate markItDoneAPIManagerDidFailToAuthenticate:self];
            }
        };
        loader.onDidFailWithError = ^(NSError *error){
            if ([self.delegate respondsToSelector:@selector(markItDoneAPIManagerDidFailWithError:)]) {
                [self.delegate markItDoneAPIManagerDidFailWithError:error];
            }
        };
    }];
}

@end
