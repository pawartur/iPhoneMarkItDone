//
//  AWToDoCell.m
//  iPhoneMarkItDone
//
//  Created by Artur Wdowiarski on 7/30/12.
//
//

#import "AWToDoCell.h"
#import "AWCoolCellBackground.h"

@implementation AWToDoCell

@synthesize nameLabel = _nameLabel;

- (void)awakeFromNib
{
    self.backgroundView = [[AWCoolCellBackground alloc] init];
    self.selectedBackgroundView = [[AWCoolCellBackground alloc] init];
    ((AWCoolCellBackground*)self.selectedBackgroundView).selected = YES;
}

@end
