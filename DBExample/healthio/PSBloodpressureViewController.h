//
//  PSBloodpressureViewController.h
//  healthio
//
//  Created by Abdul Goffar on 4/15/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSDBManager.h"
#import "PSUSER.h"

@interface PSBloodpressureViewController : UIViewController 
- (IBAction)saveBloodPressure:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *lowvalue;
@property (weak, nonatomic) IBOutlet UITextField *highvalue;
@property (nonatomic, strong) PSUSER *user;
@property (nonatomic, strong) PSDBManager *db;

@end
