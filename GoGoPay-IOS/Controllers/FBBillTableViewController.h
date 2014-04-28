//
//  FBBillTableViewController.h
//  GoGoPay-IOS
//
//  Created by cray on 4/3/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBBillTableViewController : UITableViewController
- (IBAction)navRefreshAction:(id)sender;
@property (nonatomic,strong) NSMutableArray *bills;
@property (nonatomic,strong) NSMutableArray* billsdetails;
@property (nonatomic,assign) int pageIndex;
@end
