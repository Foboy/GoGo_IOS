//
//  FBPayMethodViewController.m
//  GoGoPay-IOS
//
//  Created by cray on 4/15/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "FBPayMethodViewController.h"
#import "FBGlobalConfig.h"
#import "FBDataResult.h"

@interface FBPayMethodViewController ()

@end

@implementation FBPayMethodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goPayAction:(id)sender {

    __block MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    FBGlobalConfig *config = [FBGlobalConfig sharedConfig];
    NSDictionary *parameters = @{@"customer_id": [NSString stringWithFormat:@"%d",config.customerId ]
                                 ,@"phone": config.customerPhone};
    
    
    [FBGlobalConfig POST:config.sendValidCodeUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        FBDataResult *result = [[FBDataResult alloc] initWithJSONResponse:responseObject];
        if (result.Error == ERROR_SUCCESS) {
            NSLog(@"查询成功");
            [hud hide:YES afterDelay:0.0f];
            [self performSegueWithIdentifier:@"paymethodToValidSegue" sender:self];
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
