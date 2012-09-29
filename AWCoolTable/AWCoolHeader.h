//
//  AWCoolHeader.h
//  AWCoolTable
//
//  Created by Artur Wdowiarski on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  Based on http://www.raywenderlich.com/2106/core-graphics-101-arcs-and-paths
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
