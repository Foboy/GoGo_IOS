//
//  FBBillByMonth.h
//  GoGoPay-IOS
//
//  Created by cray on 4/3/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBBillByMonth : NSObject
@property (nonatomic,strong) NSMutableArray *bills;
@property (nonatomic,copy) NSString *month;
@property (nonatomic,assign) int monthNumber;
@end
