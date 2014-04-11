//
//  FBSuccessViewController.m
//  GoGoPay-IOS
//
//  Created by cray on 4/2/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "FBSuccessViewController.h"


@interface FBSuccessViewController ()


@end

@implementation FBSuccessViewController

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

- (IBAction)backToMain:(id)sender {
    //[self.delegate backToMainViewController];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resultBackToMain" object:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        //[nav popToRootViewControllerAnimated:NO];
        
        //code
    }];
}
@end
