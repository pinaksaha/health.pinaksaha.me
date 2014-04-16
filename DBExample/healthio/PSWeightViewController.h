//
//  PSWeightViewController.h
//  healthio
//
//  Created by Abdul Goffar on 4/15/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSUSER.h"
#import "PSDBManager.h"

@interface PSWeightViewController : UIViewController <UITextFieldDelegate>
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (nonatomic, strong) PSUSER *user;
@property (nonatomic, strong) PSDBManager *db;

@end
