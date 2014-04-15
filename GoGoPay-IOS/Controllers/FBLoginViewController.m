//
//  FBLoginViewController.m
//  GoGoPay-IOS
//
//  Created by cray on 3/31/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "FBLoginViewController.h"
#import "FBGlobalConfig.h"
#import "FBDataResult.h"

@interface FBLoginViewController ()

@end

@implementation FBLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.ibUsername setDelegate:self];
    [self.ibPassword setDelegate:self];
    [[self ibUsername] setText:@"shouyin"];
    [[self ibPassword] setText:@"111111"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //[self.storyboard instantiateViewControllerWithIdentifier:@""]
    //if ([[segue identifier] isEqualToString:@"loginToMain"]) {
    //    [segue destinationViewController];
        
        //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
         //   UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
        //    self.flipsidePopoverController = popoverController;
        //    popoverController.delegate = self;
       // }
    //}
}

- (IBAction)login:(id)sender {
    NSString *username = [[self ibUsername] text];
    NSString *password = [[self ibPassword] text];
    __block MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    FBGlobalConfig *config = [FBGlobalConfig sharedConfig];
    NSDictionary *parameters = @{@"user_name": username,@"user_password":password};
    
    [FBGlobalConfig POST:config.loginUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        FBDataResult *result = [[FBDataResult alloc] initWithJSONResponse:responseObject];
        if (result.Error == ERROR_SUCCESS) {
            [FBGlobalConfig sharedConfig].isLogin = YES;
            [FBGlobalConfig sharedConfig].catalogs = result.Data;
            NSLog(@"登陆成功");
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"登录成功！";
            [hud hide:YES afterDelay:1.5f];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccessed" object:nil];
            [self dismissViewControllerAnimated:YES completion:^{
                //[nav popToRootViewControllerAnimated:NO];
                
                //code
            }];
        }
        else
        {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = result.ErrorMessage;
            [hud hide:YES afterDelay:1.5f];
        }
    
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@",error);
    }];
}
@end
