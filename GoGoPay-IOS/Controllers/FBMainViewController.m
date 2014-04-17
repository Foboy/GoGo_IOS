//
//  FBMainViewController.m
//  GoGoPay-IOS
//
//  Created by cray on 4/2/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import "FBMainViewController.h"
#import "AMTagListView.h"
#import "AMTagView.h"
#import "Reachability.h"
#import "FBGlobalConfig.h"
#import "FBLoginViewController.H"
#import "FBDataResult.h"
#import <QuartzCore/QuartzCore.h>

@interface FBMainViewController ()

@end

@implementation FBMainViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initViews
{
    //[self.view ]
}

-(void)handelSingleTap:(UITapGestureRecognizer*)gestureRecognizer{
    NSLog(@"%s",__FUNCTION__);
    [self performSelector:@selector(singleTap:) withObject:nil afterDelay:0.2];
}
-(void)singleTap:(id)sender{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置状态栏为白色;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.ibPhoneTextField setDelegate:self];
    [self.ibAmountTextField setDelegate:self];
    
    [self initViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTagsView:) name:@"loginSuccessed" object:nil];
    
    [self.ibPhoneTextField setText:@"15882323654"];
    [self.ibAmountTextField setText:@"234.09"];

    
    // Tag's corner radius
    [[AMTagView appearance] setRadius:0];
    
    // Radius of the hole punched in the tail
    [[AMTagView appearance] setHoleRadius:0];
    
    [[AMTagView appearance] setTagLength:0];
    
    [[AMTagView appearance] setInnerTagPadding:0];
    
    [[AMTagView appearance] setTextPadding:16];
    
    [[AMTagView appearance] setInnerTagColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
    
    [[AMTagView appearance] setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
    
    
    //[[AMTagListView appearance] set]
    
    
    self.tagStates = [[NSDictionary alloc] init];
    UIView *tagsView = [self.view viewWithTag:21];
    
    self.tagListView = [[AMTagListView alloc] initWithFrame:(CGRect){0, 0, tagsView.frame.size.width, tagsView.frame.size.height}];
    self.tagListView.marginX = 10;
    self.tagListView.marginY = 10;
    [tagsView addSubview:self.tagListView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tagSelectedNotification:) name:AMTagViewNotification object:nil];
    
    if(! [FBGlobalConfig sharedConfig].isLogin)
    {
        [self performSegueWithIdentifier:@"mainToLoginIdent" sender:self];
        //FBLoginViewController *loginc = [[FBLoginViewController alloc] init];
        //[self presentViewController:loginc animated:NO completion:^{
        //}];
        return;
    }
    else
    {
        [self reloadTagsView:nil];
    }
    
    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        [FBGlobalConfig HUDShowMessage:@"网络未连接" addedToView:self.view];
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {

    };
    
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
    
    
    //if(self.tagListView.tags.count >0)
     //   [self selectTag:[self.tagListView.tags objectAtIndex:0]];
}

-(void)reloadTagsView:(NSNotification *) ns
{
    // Add one tag
    //[self.tagListView addTag:@"衣服"];
    for (AMTagView *stag in self.tagListView.tags) {
        stag.selected = NO;
        [self.tagListView removeTag:stag];
    }
    NSArray *cats = [FBGlobalConfig sharedConfig].catalogs;
    for (NSDictionary * item in cats) {
        [self.tagListView addTag:[item objectForKey:@"name"] tagId:[[item objectForKey:@"id"] intValue]];
    }
    
    // Add multiple tags
    //[self.tagListView addTags:@[@"衬衣", @"裤子", @"包包", @"领带", @"其他"]];
	// Do any additional setup after loading the view.
}

-(void)tagSelectedNotification:(NSNotification *) ns
{
    AMTagView *tag = (AMTagView *)[ns object];
    [self selectTag:tag];
    
}

-(void)selectTag:(AMTagView *)tag
{
    if (tag.selected) {
        tag.selected = NO;
        [tag setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
        [tag layoutSubviews];
    
    }
    else
    {
        tag.selected = YES;
        [tag setTextColor:[UIColor colorWithRed:1 green:0.1746 blue:0.33466 alpha:1.0]];
        [tag layoutSubviews];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mainConfirmClick:(id)sender {
    NSString *phone = [[self ibPhoneTextField] text];
    NSString *amount = [[self ibAmountTextField] text];
    __block MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    FBGlobalConfig *config = [FBGlobalConfig sharedConfig];
    NSDictionary *parameters = @{@"phone": phone};

    
    [FBGlobalConfig POST:config.getGoInfoUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        FBDataResult *result = [[FBDataResult alloc] initWithJSONResponse:responseObject];
        if (result.Error == ERROR_SUCCESS) {
            NSDictionary *customerInfo = result.Data;
            
            NSLog(@"查询成功");
            [FBGlobalConfig sharedConfig].customerId = [[customerInfo objectForKey:@"id"] intValue];
            [FBGlobalConfig sharedConfig].customerName = [customerInfo objectForKey:@"name"];
            [FBGlobalConfig sharedConfig].customerPhone = phone;
            [FBGlobalConfig sharedConfig].proportion =[[customerInfo objectForKey:@"proportion"] floatValue];
            [FBGlobalConfig sharedConfig].goCoin = [[customerInfo objectForKey:@"balance"] intValue];
            [FBGlobalConfig sharedConfig].amount =[amount floatValue];

            [hud hide:YES afterDelay:0.0f];
            [self performSegueWithIdentifier:@"mainToPayMethodSegue" sender:self];
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
