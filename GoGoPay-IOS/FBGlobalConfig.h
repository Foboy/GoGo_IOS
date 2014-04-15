//
//  FBGlobalConfig.h
//  GoGoPay-IOS
//
//  Created by cray on 4/14/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface FBGlobalConfig : NSObject
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,strong) NSArray *catalogs;

@property (nonatomic,copy) NSString *baseUrl;
@property (nonatomic,copy) NSString *loginUrl;



+ (FBGlobalConfig*)sharedConfig;
+(MBProgressHUD*)HUDShowMessage:(NSString*)msg addedToView:(UIView*)view;
+(AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
