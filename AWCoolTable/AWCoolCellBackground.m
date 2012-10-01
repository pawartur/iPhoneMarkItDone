//
//  AWCoolmCellBackground.m
//  AWCoolTable
//
//  Created by Artur Wdowiarski on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  Based on http://www.raywenderlich.com/2106/core-graphics-101-arcs-and-paths
//

#import "AWCoolCellBackground.h"
#import "AWCommon.h"

@implementation AWCoolCellBackground

@synthesize lastCell = _lastCell;
@synthesize selected = _selected;

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
    // Get the current context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Get the starting end ending color for our gradient
    UIColor *whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    UIColor *lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    
    // Get the color for our separating line
    UIColor *separatorColor = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1.0];
    
    // Get out canvas
    CGRect paperRect = self.bounds;
    
    // Draw the gradient on the canvas
    if (_selected) {
        drawLinearGradient(context, paperRect, lightGrayColor.CGColor, separatorColor.CGColor);
    } else {
        drawLinearGradient(context, paperRect, whiteColor.CGColor, lightGrayColor.CGColor);
    }
    
    if (!_lastCell) {
        // Get the rect for our border stroke (a subrect of our canvas)
        CGRect strokeRect = paperRect;
        strokeRect.size.height -= 1;
        strokeRect = rectFor1PxStroke(strokeRect);
        
        // Set the border stroke color
        CGContextSetStrokeColorWithColor(context, whiteColor.CGColor);
        // Set the border stroke line width
        CGContextSetLineWidth(context, 1.0);
        // And make the rectangular border stroke
        CGContextStrokeRect(context, strokeRect);
        
        // Calculate the starting and ending points for our separating stroke
        CGPoint startPoint = CGPointMake(paperRect.origin.x, paperRect.origin.y + paperRect.size.height - 1);
        CGPoint endPoint = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y + paperRect.size.height - 1);
        
        // Draw the separator stroke
        draw1PxStroke(context, startPoint, endPoint, separatorColor.CGColor);
    }else {
        CGContextSetStrokeColorWithColor(context, whiteColor.CGColor);
        CGContextSetLineWidth(context, 1.0);
        
        // In case of the last cell draw a similar border but without the bottom part of it
        CGPoint pointA = CGPointMake(paperRect.origin.x, paperRect.origin.y + paperRect.size.height - 1);
        CGPoint pointB = CGPointMake(paperRect.origin.x, paperRect.origin.y);
        CGPoint pointC = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y);
        CGPoint pointD = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y + paperRect.size.height - 1);
        
        draw1PxStroke(context, pointA, pointB, whiteColor.CGColor);
        draw1PxStroke(context, pointB, pointC, whiteColor.CGColor);
        draw1PxStroke(context, pointC, pointD, whiteColor.CGColor);
    }
}

@end
