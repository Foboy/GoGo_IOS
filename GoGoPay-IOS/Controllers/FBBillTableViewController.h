//
//  FBBillTableViewController.h
//  GoGoPay-IOS
//
//  Created by cray on 4/3/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBBillTableViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *bills;
@property (nonatomic,strong) NSArray* realbills;
@property (nonatomic,assign) int pageIndex;
@end
