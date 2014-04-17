//
//  FBPayInfoViewController.h
//  GoGoPay-IOS
//
//  Created by cray on 4/15/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBPayInfoViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *ibPayinfoName;
@property (weak, nonatomic) IBOutlet UILabel *ibPayinfoGoCoin;
@property (weak, nonatomic) IBOutlet UILabel *ibPayinfoAmount;
@end
