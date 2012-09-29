//
//  AWCoolHeader.m
//  AWCoolTable
//
//  Created by Artur Wdowiarski on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  Based on http://www.raywenderlich.com/2106/core-graphics-101-arcs-and-paths
//

#import "AWCoolHeader.h"
#import "AWCommon.h"

@implementation AWCoolHeader

@synthesize titleLabel = _titleLabel;
@synthesize lightColor = _lightColor;
@synthesize darkColor = _darkColor;

- (id)init
{
    if ((self = [super init])) {
        // Init self
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        // Init titleLabel
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.opaque = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _titleLabel.shadowOffset = CGSizeMake(0, -1);
        
        // Add titleLabel as a subview
        [self addSubview:_titleLabel];
        
        // Init colors for future use
        self.lightColor = [UIColor colorWithRed:0.0/255.0 green:123.0/255.0 blue:204.0/255.0 alpha:1.0];
        self.darkColor = [UIColor colorWithRed:0.0/255.0 green:123.0/255.0 blue:204.0/255.0 alpha:1.0];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();    
    
    CGColorRef lightColor = _lightColor.CGColor;
    CGColorRef darkColor = _darkColor.CGColor;
    
    CGColorRef whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5].CGColor;   
    
    CGContextSetFillColorWithColor(context, whiteColor);
    CGContextFillRect(context, _paperRect);
    
    // Save the current context state
    CGContextSaveGState(context);
    // Set shadow params
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor);
    // Set fill color
    CGContextSetFillColorWithColor(context, lightColor);
    // Fill the colored box. Because we set the shadow, this act of filling will
    // cause a shadow to appear underneath the path that we're drawing (in this
    // case _coloredBoxRect).
    CGContextFillRect(context, _coloredBoxRect);
    // Restore the context
    CGContextRestoreGState(context);
    
    // Now add the gradient and gloss
    drawGlossAndGradient(context, _coloredBoxRect, lightColor, darkColor)  ;
    
    // Add a border to the colored box
    CGContextSetStrokeColorWithColor(context, darkColor);
    CGContextSetLineWidth(context, 1.0);    
    CGContextStrokeRect(context, rectFor1PxStroke(_coloredBoxRect));
}

- (void) layoutSubviews
{
    // Prepare the rect for colored box
    CGFloat coloredBoxMargin = 6.0;
    CGFloat coloredBoxHeight = 40.0;
    _coloredBoxRect = CGRectMake(coloredBoxMargin, 
                                 coloredBoxMargin, 
                                 self.bounds.size.width-coloredBoxMargin*2, 
                                 coloredBoxHeight);
    
    // Prepare the rect for paper margin
    CGFloat paperMargin = 9.0;
    _paperRect = CGRectMake(paperMargin, 
                            CGRectGetMaxY(_coloredBoxRect), 
                            self.bounds.size.width-paperMargin*2, 
                            self.bounds.size.height-CGRectGetMaxY(_coloredBoxRect));
    
    _titleLabel.frame = _coloredBoxRect;
    
}

@end
