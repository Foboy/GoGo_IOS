//
//  FBBillCell.h
//  GoGoPay-IOS
//
//  Created by cray on 4/3/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBBillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ibBillNameAndPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibBillDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibBillPayMethodLabel;
@property (weak, nonatomic) IBOutlet UILabel *ibBillAmountLabel;

@end
