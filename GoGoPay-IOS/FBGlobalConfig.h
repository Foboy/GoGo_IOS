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
@property (nonatomic,assign) float amount;
@property (nonatomic,copy) NSString* customerName;
@property (nonatomic,assign) int goCoin;
@property (nonatomic,assign) float proportion;
@property (nonatomic,assign) int customerId;
@property (nonatomic,copy) NSString* customerPhone;


@property (nonatomic,copy) NSString *baseUrl;
@property (nonatomic,copy) NSString *loginUrl;
@property (nonatomic,copy) NSString *getGoInfoUrl;
@property (nonatomic,copy) NSString *sendValidCodeUrl;
@property (nonatomic,copy) NSString *validateUrl;
@property (nonatomic,copy) NSString *billListUrl;


+ (FBGlobalConfig*)sharedConfig;
+(MBProgressHUD*)HUDShowMessage:(NSString*)msg addedToView:(UIView*)view;
+(AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+(NSString *)floatToDecimalString:(float)amount;
@end
