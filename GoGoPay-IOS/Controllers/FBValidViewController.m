//
//  FBValidViewController.m
//  GoGoPay-IOS
//
//  Created by cray on 4/2/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "FBValidViewController.h"
#import "FBSuccessViewController.h"

@interface FBValidViewController ()

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
@end
