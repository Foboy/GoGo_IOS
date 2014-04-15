//
//  FBDataResult.h
//  GoGoPay-IOS
//
//  Created by cray on 4/14/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBDataResult : NSObject
@property (nonatomic,assign) int Error;
@property (nonatomic,assign) int Id;
@property (nonatomic,copy) NSString * ErrorMessage;
@property (nonatomic,copy) NSString * ExMessage;
@property (nonatomic,strong) id Data;

-(id)initWithJSONResponse:(NSDictionary *) response;
@end
