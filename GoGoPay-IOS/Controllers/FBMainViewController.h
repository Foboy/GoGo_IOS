//
//  FBMainViewController.h
//  GoGoPay-IOS
//
//  Created by cray on 4/2/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBValidViewController.h"
#import "AutoHideKeyboardViewController.h"
#import "FBTextField.h"
#import "AMTagListView.h"

@interface FBMainViewController : AutoHideKeyboardViewController<UITextFieldDelegate>
- (IBAction)mainConfirmClick:(id)sender;
@property (weak, nonatomic) IBOutlet FBTextField *ibPhoneTextField;
@property (weak, nonatomic) IBOutlet FBTextField *ibAmountTextField;
@property (nonatomic,strong) AMTagListView *tagListView;
@property (nonatomic,strong) NSDictionary *tagStates;
@end
