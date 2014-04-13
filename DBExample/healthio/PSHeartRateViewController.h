//
//  PSHeartRateViewController.h
//  healthio
//
//  Created by Abdul Goffar on 4/13/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSDBManager.h"
#import "PSUSER.h"

@interface PSHeartRateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *value;
@property (weak, nonatomic) IBOutlet UILabel *heartRate;
@property (nonatomic, strong) PSUSER *user;
@property (nonatomic, strong) PSDBManager *db;
- (IBAction)saveHeartRate:(id)sender;

@end
