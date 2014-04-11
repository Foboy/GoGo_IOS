//
//  FBUIViewSingleBorder.m
//  GoGoPay-IOS
//
//  Created by cray on 4/2/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "FBUIViewSingleBorder.h"

@implementation FBUIViewSingleBorder

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CALayer *bottomBorder = [CALayer layer];
    float height=self.frame.size.height-1.0f;
    float width=self.frame.size.width;
    bottomBorder.frame = CGRectMake(0.0f, height, width, 1.0f);
    bottomBorder.backgroundColor = [[UIColor colorWithRed:195.0f/255.0f green:195.0f/255.0f blue:195.0f/255.0f alpha:1.0f] CGColor];

    [self.layer addSublayer:bottomBorder];
    // Drawing code
}


@end
