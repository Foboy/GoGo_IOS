//
//  FBLoginViewController.h
//  GoGoPay-IOS
//
//  Created by cray on 3/31/14.
//  Copyright (c) 2014 foboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoHideKeyboardViewController.h"

@interface FBLoginViewController : AutoHideKeyboardViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ibUsername;
@property (weak, nonatomic) IBOutlet UITextField *ibPassword;

- (IBAction)login:(id)sender;

@end
