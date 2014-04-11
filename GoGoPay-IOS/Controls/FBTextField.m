//
//  FBTextField.m
//  GoGoPay-IOS
//
//  Created by cray on 4/2/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "FBTextField.h"
#import <QuartzCore/QuartzCore.h>

@implementation FBTextField

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
    
    self.layer.borderColor =[[UIColor colorWithRed:195.0f/255.0f green:195.0f/255.0f blue:195.0f/255.0f alpha:1.0f] CGColor];
    self.layer.borderWidth = 1.0f;
    // Drawing code
}


@end
