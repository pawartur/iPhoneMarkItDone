//
//  AWLoginViewController.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWLoginViewController.h"
#import "AWKeychainWrapper.h"
#import "AWConstants.h"

@interface AWLoginViewController ()

@end

@implementation AWLoginViewController

@synthesize passwordTextField = _passwordTextField;
@synthesize usernameTextField = _usernameTextField;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPasswordTextField:nil];
    [self setUsernameTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)login:(UIButton *)sender {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [AWKeychainWrapper createKeychainValue:username forIdentifier:SAVED_USERNAME];
    [AWKeychainWrapper createKeychainValue:password forIdentifier:SAVED_PASSWORD];
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
