//
//  NSDictionary+CaseIgnore.m
//  GoGoPay-IOS
//
//  Created by cray on 4/17/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "NSDictionary+CaseIgnore.h"

@implementation NSDictionary (CaseIgnore)
- (id)objectForCaseInsensitiveKey:(NSString *)key {
    NSArray *allKeys = [self allKeys];
    for (NSString *str in allKeys) {
        if ([key caseInsensitiveCompare:str] == NSOrderedSame) {
            return [self objectForKey:str];
        }
    }
    return nil;
}
@end
