//
//  AWCoolButton.m
//  AWCoolButton
//
//  Created by Artur Wdowiarski on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AWCoolButton.h"
#import "AWCommon.h"

@implementation AWCoolButton

@synthesize hue = _hue;
@synthesize saturation = _saturation;
@synthesize brightness = _brightness;

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        _hue = 1.0;
        _saturation = 1.0;
        _brightness = 1.0;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    // Differ the brightness in the selected state
    CGFloat actualBrightness = _brightness;
    if (self.state == UIControlStateHighlighted) {
        actualBrightness -= 0.10;
    } 
    
    // Get the current context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Prepare the colors for the shadow and the button itself
    CGColorRef blackColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    CGColorRef highlightStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4].CGColor;
    CGColorRef highlightStop = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5].CGColor;
    
    CGColorRef outerTop = [UIColor colorWithHue:_hue saturation:_saturation brightness:1.0*actualBrightness alpha:1.0].CGColor;
    CGColorRef outerBottom = [UIColor colorWithHue:_hue saturation:_saturation brightness:0.80*actualBrightness alpha:1.0].CGColor;
    CGColorRef innerStroke = [UIColor colorWithHue:_hue saturation:_saturation brightness:0.80*actualBrightness alpha:1.0].CGColor;
    CGColorRef innerTop = [UIColor colorWithHue:_hue saturation:_saturation brightness:0.90*actualBrightness alpha:1.0].CGColor;
    CGColorRef innerBottom = [UIColor colorWithHue:_hue saturation:_saturation brightness:0.70*actualBrightness alpha:1.0].CGColor;
    
    // Get a slightly smaller rect for the button
    // We leave 5px each side to have place to draw the shadow
    CGFloat outerMargin = 5.0f;
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 6.0);
    
    // Get an even smaller inner rect that will have a slightly different
    // gradient than the outer one. This will create a bevel-type effect.
    CGFloat innerMargin = 3.0f;
    CGRect innerRect = CGRectInset(outerRect, innerMargin, innerMargin);
    CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, 6.0);
    
    // And now a place for the highlight
    CGFloat highlightMargin = 2.0f;
    CGRect highlightRect = CGRectInset(outerRect, highlightMargin, highlightMargin);
    CGMutablePathRef highlightPath = createRoundedRectForRect(highlightRect, 6.0);
    
    if (self.state != UIControlStateHighlighted) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, outerTop);
        CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor);
        CGContextAddPath(context, outerPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    }
    
    CGContextSaveGState(context);
    CGContextAddPath(context, outerPath);
    CGContextClip(context);
    drawGlossAndGradient(context, outerRect, outerTop, outerBottom);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    drawGlossAndGradient(context, innerRect, innerTop, innerBottom);
    CGContextRestoreGState(context);
    
    if (self.state != UIControlStateHighlighted) {
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, 4.0);
        CGContextAddPath(context, outerPath);
        CGContextAddPath(context, highlightPath);
        CGContextEOClip(context);
        drawLinearGradient(context, outerRect, highlightStart, highlightStop);
        CGContextRestoreGState(context);
    }
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, blackColor);
    CGContextAddPath(context, outerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, innerStroke);
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    CGContextAddPath(context, innerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);    
    
    CFRelease(outerPath);
    CFRelease(innerPath);
    CFRelease(highlightPath);
}

- (void)setHue:(CGFloat)hue {
    _hue = hue;
    [self setNeedsDisplay];
}

- (void)setSaturation:(CGFloat)saturation {
    _saturation = saturation;
    [self setNeedsDisplay];
}

- (void)setBrightness:(CGFloat)brightness {
    _brightness = brightness;
    [self setNeedsDisplay];
}

- (void)hesitateUpdate
{
    [self setNeedsDisplay];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self setNeedsDisplay];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self setNeedsDisplay];
    [self performSelector:@selector(hesitateUpdate) withObject:nil afterDelay:0.1];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self setNeedsDisplay];
    [self performSelector:@selector(hesitateUpdate) withObject:nil afterDelay:0.1];
}

@end
