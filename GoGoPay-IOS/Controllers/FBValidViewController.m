//
//  FBValidViewController.m
//  GoGoPay-IOS
//
//  Created by cray on 4/2/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "FBValidViewController.h"
#import "FBSuccessViewController.h"
#import "FBGlobalConfig.h"
#import "FBDataResult.h"

@interface FBValidViewController ()
@property (nonatomic,strong) NSTimer* timer;
@property (nonatomic,assign) int seconds;
@end

@implementation FBValidViewController

-(void)backToMainViewController
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

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
    
    [self.ibValidCode setDelegate:self];
    
    self.seconds = 120;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resultClosedNotification:) name:@"resultBackToMain" object:nil];
}

-(void)resultClosedNotification:(NSNotification *) ns
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    //if ([[segue identifier] isEqualToString:@"payToSuccessSeque"]) {

    //    [segue destinationViewController];
    
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    //   UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
    //    self.flipsidePopoverController = popoverController;
    //    popoverController.delegate = self;
    // }
    //}
}

-(void)timerFireMethod:(NSTimer *)theTimer {
    if (self.seconds <= 1) {
        [theTimer invalidate];
        
        [self.ibReSendValidCode setTitle:@"重发"];
        [self.ibReSendValidCode setTintColor:[UIColor whiteColor]];
        [self.ibReSendValidCode  setEnabled:YES];
    }else{
        self.seconds--;
        [self.ibReSendValidCode setTitle:[NSString stringWithFormat:@"%d秒",self.seconds ]];
        [self.ibReSendValidCode  setEnabled:NO];
    }
}

- (void)releaseTImer {
    if (self.timer) {
            if ([self.timer isValid]) {
                [self.timer invalidate];
            }
    }
}
- (IBAction)resendValidCodeAction:(id)sender {
    
    //[self releaseTImer];
    
    __block MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    FBGlobalConfig *config = [FBGlobalConfig sharedConfig];
    NSDictionary *parameters = @{@"customer_id": [NSString stringWithFormat:@"%d",config.customerId ]};
    
    
    [FBGlobalConfig POST:config.sendValidCodeUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        FBDataResult *result = [[FBDataResult alloc] initWithJSONResponse:responseObject];
        if (result.Error == ERROR_SUCCESS) {
            NSLog(@"查询成功");
            self.seconds = 120;

            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
            [hud hide:YES afterDelay:0.0f];
            
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

- (IBAction)goPayConfirmAction:(id)sender {
    __block MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    FBGlobalConfig *config = [FBGlobalConfig sharedConfig];
    NSDictionary *parameters = @{@"customer_id": [NSString stringWithFormat:@"%d",config.customerId ],
                                 @"amount": [NSString stringWithFormat:@"%f",config.amount],
                                 @"code": [self.ibValidCode text],
                                 @"type_ids":  @"[1,2]"};
    //[NSString stringWithFormat:@"%@",config.catalogs]
    
    [FBGlobalConfig POST:config.validateUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        FBDataResult *result = [[FBDataResult alloc] initWithJSONResponse:responseObject];
        if (result.Error == ERROR_SUCCESS) {
            NSLog(@"查询成功");
            
            [hud hide:YES afterDelay:0.0f];
            [self performSegueWithIdentifier:@"goPaySuccessSegue" sender:self];
            //
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
