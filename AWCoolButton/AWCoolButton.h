//
//  AWCoolButton.h
//  AWCoolButton
//
//  Created by Artur Wdowiarski on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  Based on http://www.raywenderlich.com/2134/core-graphics-101-glossy-buttons
//

#import <UIKit/UIKit.h>

@interface AWCoolButton : UIButton

@property(nonatomic)  CGFloat hue;
@property(nonatomic)  CGFloat saturation;
@property(nonatomic)  CGFloat brightness;

@end
