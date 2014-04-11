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
    
    
    UIView *tagsView = [self.view viewWithTag:21];
    
    self.tagListView = [[AMTagListView alloc] initWithFrame:(CGRect){0, 0, tagsView.frame.size.width, tagsView.frame.size.height}];
    self.tagListView.marginX = 10;
    self.tagListView.marginY = 10;
    [tagsView addSubview:self.tagListView];
    
    // Add one tag
    [self.tagListView addTag:@"衣服"];
    
    // Add multiple tags
    [self.tagListView addTags:@[@"衬衣", @"裤子", @"包包", @"领带", @"其他"]];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tagSelectedNotification:) name:AMTagViewNotification object:nil];
    
    if(self.tagListView.tags.count >0)
        [self selectTag:[self.tagListView.tags objectAtIndex:0]];
}

-(void)tagSelectedNotification:(NSNotification *) ns
{
    AMTagView *tag = (AMTagView *)[ns object];
    [self selectTag:tag];
    
}

-(void)selectTag:(AMTagView *)tag
{
    for (AMTagView *stag in self.tagListView.tags) {
        [stag setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
        [stag layoutSubviews];
    }
    [tag setTextColor:[UIColor colorWithRed:1 green:0.1746 blue:0.33466 alpha:1.0]];
    [tag layoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
