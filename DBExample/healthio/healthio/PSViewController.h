//
//  PSViewController.h
//  healthio
//
//  Created by Pinak Saha on 4/6/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSViewController : UIViewController <UITextFieldDelegate>

- (IBAction)sendData:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *errorLable;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

@end
