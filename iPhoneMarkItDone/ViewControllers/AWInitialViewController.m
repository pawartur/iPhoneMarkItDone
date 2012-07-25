//
//  AWInitialViewController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWInitialViewController.h"
#import "AWKeychainWrapper.h"
#import "AWConstants.h"

NSString * const kNetworkErrorMessage = @"Failed to check Your username and password. Pleace, check You network connection.";
NSString * const kRetryLoginActionName = @"Retry Login";
NSString * const kLoginActionName = @"Login";

@interface AWInitialViewController ()

@end

@implementation AWInitialViewController

#pragma mark - View LifeCycle

@synthesize apiManager = _apiManager;
@synthesize infoLabel = _infoLabel;
@synthesize actionButton = _actionButton;
@synthesize usernameTextField = _usernameTextField;
@synthesize passwordTextField = _passwordTextField;

-(void)viewDidLoad{
    [super viewDidLoad];
    self.apiManager = [AWMarkItDoneAPIManager sharedManager];
    self.apiManager.delegate = self;
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSString *savedUsername = [AWKeychainWrapper keychainStringFromMatchingIdentifier:SAVED_USERNAME];
    NSString *savedPassword = [AWKeychainWrapper keychainStringFromMatchingIdentifier:SAVED_PASSWORD];
    
    if (!(savedUsername && savedPassword)) {
        [self prepareForLogin];
        return;
    }
    
    self.apiManager.username = savedUsername;
    self.apiManager.password = savedPassword;
    [self.apiManager authenticate];
}

- (void)viewDidUnload {
    [self setInfoLabel:nil];
    [self setActionButton:nil];
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [self setApiManager:nil];
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
    [self showInfo:kNetworkErrorMessage forFurtherActionWithName:kRetryLoginActionName];
}

#pragma mark - UITextFieldDelegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}


#pragma mark - IB Actions

-(void)makeAction:(UIButton *)sender{
    NSString *actionName = self.actionButton.titleLabel.text;
    if ([actionName isEqualToString:kLoginActionName]) {
        NSString *username = self.usernameTextField.text;
        NSString *password = self.passwordTextField.text;
        
        [AWKeychainWrapper createKeychainValue:username forIdentifier:SAVED_USERNAME];
        [AWKeychainWrapper createKeychainValue:password forIdentifier:SAVED_PASSWORD];
        
        self.apiManager.username = username;
        self.apiManager.password = password;
        [self.apiManager authenticate];
    }else if([actionName isEqualToString:kRetryLoginActionName]){
        [self prepareForLogin];
    }
}

#pragma mark - Custom Methods
-(void)prepareForLogin{
    self.infoLabel.hidden = YES;
    self.usernameTextField.hidden = NO;
    self.passwordTextField.hidden = NO;
    self.actionButton.hidden = NO;
    [self.actionButton setTitle:kLoginActionName forState:UIControlStateNormal];
    self.actionButton.hue = 0.3;
    self.actionButton.saturation = 0.5;
    self.actionButton.brightness = 0.67;
}

-(void)showInfo:(NSString *)info forFurtherActionWithName:(NSString *)furtherActionName{
    self.usernameTextField.hidden = YES;
    self.passwordTextField.hidden = YES;
    self.actionButton.hidden = NO;
    self.infoLabel.hidden = NO;
    self.infoLabel.textColor = [UIColor redColor];
    self.infoLabel.text = info;
    [self.actionButton setTitle:furtherActionName forState:UIControlStateNormal];
    self.actionButton.hue = 0.56;
    self.actionButton.saturation = 1.0;
    self.actionButton.brightness = 0.8;
}

@end
