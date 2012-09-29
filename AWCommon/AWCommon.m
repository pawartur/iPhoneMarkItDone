//
//  AWCommon.m
//  AWCommon
//
//  Created by Artur Wdowiarski on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  Based on code from http://www.raywenderlich.com
//

#import "AWCommon.h"

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor)
{
    // Get the RGB color space for our device
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // We will provide just two colors for the gradient- the starting (0.0)
    // and ending (1.0) one
    CGFloat locations[] = {0.0, 1.0};
    
    // And we will provide them in an NSArray
    NSArray *colors = [NSArray arrayWithObjects:(__bridge_transfer id)startColor, (__bridge_transfer id)endColor, nil];
    
    // Make the gradient object and get a reference to it
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge_retained CFArrayRef) colors, locations);
    
    // Calculate the points of our given rectangle, where we want to draw the gradient
    // It will be drawn from the middle down
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    // Save the CG state so that we can return to it
    // after we clip to our context and draw the gradient 
    CGContextSaveGState(context);
    
    // Push our given rectangle to the context...
    CGContextAddRect(context, rect);
    
    // And clip to the context, so we draw only on the rectangle
    CGContextClip(context);
    
    // Draw the gradient
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    // Restore the CG state, so that we can draw somewhere else in the future
    CGContextRestoreGState(context);
    
    // Release the gradient and color space that we created earlier
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

void drawGlossAndGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor)
{
    // First drow the gradient
    drawLinearGradient(context, rect, startColor, endColor);
    
    // Now we'll emulate gloss by applying a gradient alpha mask
    CGColorRef glossColor1 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.35].CGColor;
    CGColorRef glossColor2 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
    
    // Calculate the top half of the given rect (where we'll draw "gloss" gradient)
    CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/2);
    
    // Draw the "gloss" gradient
    drawLinearGradient(context, topHalf, glossColor1, glossColor2);
    
}

void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color)
{
    // Save the CG context state before drawing
    CGContextSaveGState(context);
    
    // We set the line cap to have a “square” ending, which makes the line extend 
    // 1/2 of the line width beyond the end – in our case 1/2 point
    // This will make this funciton play nicely with our rectFor1PxStroke
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    // Set the stroke color and line width
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, 1.0);
    
    // Move to the starting point for our line..
    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
    // ... and add a line to the ending point
    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
    
    // Draw the line
    CGContextStrokePath(context);
    
    // Restore the CG context state after drawing
    CGContextRestoreGState(context);        
    
}


CGRect rectFor1PxStroke(CGRect rect)
{
    // When Core Graphics strokes a path, it draws the stroke on the middle of the exact edge of the path.
    // We modify the rectangle so the edge is halfway through the inside pixel of the original rectangle,
    // so the stroke behavior works correctly.
    return CGRectMake(rect.origin.x + 0.5, rect.origin.y + 0.5, rect.size.width - 1, rect.size.height - 1);
}

CGMutablePathRef createArcPathFromBottomOfRect(CGRect rect, CGFloat arcHeight)
{
    // Calculate the rectangle in which the arc is going to be drawn
    // (This is the smallest rectangle that you have to subtract from 
    // the original rectangle in order to have the differenca that is
    // a rectangle without arc)
    CGRect arcRect = CGRectMake(rect.origin.x, 
                                rect.origin.y + rect.size.height - arcHeight, 
                                rect.size.width,
                                arcHeight);
    
    // This is a formula to calculate an arc radius based on a arc rectangle...
    // It looks complicated but it's based solely on Intersecting Chord Theorem
    CGFloat arcRadius = (arcRect.size.height/2) + (pow(arcRect.size.width, 2) / (8*arcRect.size.height));
    
    // Calculate the center of the arc
    CGPoint arcCenter = CGPointMake(arcRect.origin.x + arcRect.size.width/2, 
                                    arcRect.origin.y + arcRadius);
    
    // Calculate the start end end angles of our arc using some simple trigonometry
    CGFloat angle = acos(arcRect.size.width / (2*arcRadius));
    CGFloat startAngle = radians(180) + angle;
    CGFloat endAngle = radians(360) - angle;
    
    // Create a path for our arc...
    CGMutablePathRef path = CGPathCreateMutable();
    
    // .. and add the arc to it
    CGPathAddArc(path, NULL, arcCenter.x, arcCenter.y, arcRadius, startAngle, endAngle, 0);
    
    // Add lines aroung the edges withour arcs
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    
    return path;    
}

CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius)
{
    // Create a path for our rounded rect
    CGMutablePathRef path = CGPathCreateMutable();
    
    // Move to the top middle of our given rect
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    // Top right corner
    // NOTE!!: CGPathAddArcToPoint automatically draws a line from current position to the beginning of the arc
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    // Bottom right corned
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    // Bottom left corner
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    // Top left corner
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
    
    // Close the subpath (draw a line from the end of the last arc to the place where we started)
    CGPathCloseSubpath(path);
    
    return path;        
}
