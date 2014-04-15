//
//  FBGlobalConfig.m
//  GoGoPay-IOS
//
//  Created by cray on 4/14/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "FBGlobalConfig.h"


@implementation FBGlobalConfig

@synthesize isLogin;
@synthesize catalogs;

@synthesize baseUrl;
@synthesize loginUrl;

+ (FBGlobalConfig*)sharedConfig
{
    static FBGlobalConfig* _sharedConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConfig = [[FBGlobalConfig alloc] init];
        _sharedConfig.baseUrl = @"http://192.168.1.100/index.php?url=";
        _sharedConfig.loginUrl = [_sharedConfig.baseUrl stringByAppendingString:@"user/applogin"];
    });
    
    return _sharedConfig;
}

+ (MBProgressHUD*)HUDShowMessage:(NSString*)msg addedToView:(UIView*)view
{
    static MBProgressHUD* hud = nil;
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.hidden = NO;
    hud.alpha = 1.0f;
    [hud hide:YES afterDelay:1.0f];
    return hud;
}
+(AFHTTPRequestOperation *)POST:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return [manager POST:URLString parameters:parameters success:success failure:failure];
}
@end
