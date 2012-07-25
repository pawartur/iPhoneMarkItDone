//
//  AWInitialViewController.h
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWMarkItDoneAPIManagerDelegate.h"

@interface AWInitialViewController : UIViewController <AWMarkItDoneAPIManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UIButton *retryLoginButton;

- (IBAction)retryLogin:(UIButton *)sender;

@end
