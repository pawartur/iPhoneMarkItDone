//
//  AWInitialViewController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWInitialViewController.h"
#import "AWMarkItDoneAPIManager.h"
#import "AWKeychainWrapper.h"
#import "AWConstants.h"

@interface AWInitialViewController ()

@end

@implementation AWInitialViewController

#pragma mark - View LifeCycle

@synthesize infoLabel = _infoLabel;
@synthesize retryLoginButton = _retryLoginButton;

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AWMarkItDoneAPIManager *apiManager = [AWMarkItDoneAPIManager sharedManager];
    apiManager.delegate = self;
    
    NSString *savedUsername = [AWKeychainWrapper keychainStringFromMatchingIdentifier:SAVED_USERNAME];
    NSString *savedPassword = [AWKeychainWrapper keychainStringFromMatchingIdentifier:SAVED_PASSWORD];
    
    if (!(savedUsername && savedPassword)) {
        [self performSegueWithIdentifier:@"showLoginScreen" sender:self];
        return;
    }
    
    apiManager.username = savedUsername;
    apiManager.password = savedPassword;
    [apiManager authenticate];
}

- (void)viewDidUnload {
    [self setInfoLabel:nil];
    [self setRetryLoginButton:nil];
    [super viewDidUnload];
}

#pragma mark - AWMarkItDoneAPIManagerDelegate Methods

-(void)markItDoneAPIManagerDidAuthenticate:(AWMarkItDoneAPIManager *)manager{
    [self performSegueWithIdentifier:@"showTodos" sender:self];
}

-(void)markItDoneAPIManagerDidFailToAuthenticate:(AWMarkItDoneAPIManager *)manager{
    [self performSegueWithIdentifier:@"showLoginScreen" sender:self];
}

-(void)markItDoneAPIManagerDidFailWithError:(NSError *)error{
    self.infoLabel.textColor = [UIColor redColor];
    self.infoLabel.text = @"Failed to check Your username and password. Pleace, check You network connection.";
    self.retryLoginButton.hidden = NO;
}

#pragma mark - IB Actions

- (IBAction)retryLogin:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showLoginScreen" sender:self];
    self.retryLoginButton.hidden = YES;
}
@end
