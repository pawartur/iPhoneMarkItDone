//
//  AWCoolHeader.h
//  AWCoolTable
//
//  Created by Artur Wdowiarski on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWCoolHeader : UIView{
    CGRect _coloredBoxRect;
    CGRect _paperRect;
}

@property (retain) UILabel *titleLabel;
@property (retain) UIColor *lightColor;
@property (retain) UIColor *darkColor;

@end
