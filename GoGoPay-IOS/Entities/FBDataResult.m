//
//  FBDataResult.m
//  GoGoPay-IOS
//
//  Created by cray on 4/14/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "FBDataResult.h"

@implementation FBDataResult

@synthesize Error;
@synthesize Id;
@synthesize ErrorMessage;
@synthesize ExMessage;
@synthesize Data;

-(id)initWithJSONResponse:(NSDictionary *) response
{
    if (self = [super init]) {
        self.ErrorMessage = [response objectForKey:@"ErrorMessage"];
        self.ExMessage = [response objectForKey:@"ExMessage"];
        self.Error = [[response objectForKey:@"Error"] intValue];
        if ([response objectForKey:@"Id"] != [NSNull null]) {
            self.Id = [[response objectForKey:@"Id"] intValue];
        }
        
        self.Data = [response objectForKey:@"Data"];
    }
    return self;
}
@end
