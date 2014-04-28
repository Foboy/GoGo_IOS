//
//  FBValidViewController.h
//  GoGoPay-IOS
//
//  Created by cray on 4/2/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoHideKeyboardViewController.h"
#import "FBTextField.h"


@interface FBValidViewController : AutoHideKeyboardViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet FBTextField *ibValidCode;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ibReSendValidCode;
- (IBAction)resendValidCodeAction:(id)sender;
- (IBAction)goPayConfirmAction:(id)sender;

@end
