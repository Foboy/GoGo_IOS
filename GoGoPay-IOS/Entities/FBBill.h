//
//  FBBill.h
//  GoGoPay-IOS
//
//  Created by cray on 4/3/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBBill : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,assign) int goamount;
@property (nonatomic,assign) float amount;
@property (nonatomic,assign) int payMethod;
@end
