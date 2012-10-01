//
//  AWToDoFilterSectionHeaderView.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 8/16/12.
//
//

#import "AWCommon.h"
#import "AWToDoFilterSectionHeaderView.h"

@implementation AWToDoFilterSectionHeaderView

@synthesize titleLabel = _titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = UITextAlignmentLeft;
        _titleLabel.opaque = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _titleLabel.shadowOffset = CGSizeMake(0, -1);
        
        CGFloat titleLabelMargin = 10.0;
        _titleLabel.frame = CGRectMake(titleLabelMargin, 0, self.frame.size.width - titleLabelMargin, self.frame.size.height);
        
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *lightColor = [UIColor colorWithRed:0.0/255.0 green:7.0/255.0 blue:7.0/255.0 alpha:1.0];
    UIColor *darkColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    drawGlossAndGradient(context, self.bounds, lightColor.CGColor, darkColor.CGColor);
}

@end
