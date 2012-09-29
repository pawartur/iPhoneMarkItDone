//
//  AWCommon.h
//  AWCommon
//
//  Created by Artur Wdowiarski on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  Based on code from http://www.raywenderlich.com
//

#import <Foundation/Foundation.h>

static inline double radians (double degrees) { return degrees * M_PI/180; }

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);
void drawGlossAndGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);
void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color);
CGRect rectFor1PxStroke(CGRect rect);
CGMutablePathRef createArcPathFromBottomOfRect(CGRect rect, CGFloat arcHeight);
CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius);
