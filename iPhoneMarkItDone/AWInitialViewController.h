//
//  AWInitialViewController.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWMarkItDoneAPIManager.h"
#import "AWMarkItDoneAPIManagerDelegate.h"
#import "AWCoolButton.h"

@interface AWInitialViewController : UIViewController <AWMarkItDoneAPIManagerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet AWCoolButton *actionButton;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) AWMarkItDoneAPIManager *apiManager;

- (IBAction)makeAction:(UIButton *)sender;

-(void)prepareForLogin;
-(void)showInfo:(NSString *)info forFurtherActionWithName:(NSString *)furtherActionName;

@end
