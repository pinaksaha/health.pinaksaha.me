//
//  PSCreateProfileViewController.h
//  healthio
//
//  Created by Javlon Usmanov on 4/15/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSDBManager.h"
#import "PSUSER.h"

@interface PSCreateProfileViewController : UIViewController <UITextFieldDelegate>
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasswordValue;
@property (weak, nonatomic) IBOutlet UILabel *reEnterPasswordLabel;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (nonatomic, strong) PSDBManager *db;
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;

@end
