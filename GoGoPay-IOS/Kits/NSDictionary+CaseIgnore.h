//
//  NSDictionary+CaseIgnore.h
//  GoGoPay-IOS
//
//  Created by cray on 4/17/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CaseIgnore)
- (id)objectForCaseInsensitiveKey:(NSString *)key;
@end
