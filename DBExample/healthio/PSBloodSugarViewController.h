//
//  PSBloodSugarViewController.h
//  healthio
//
//  Created by Abdul Goffar on 4/17/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSUSER.h"
#import "PSDBManager.h"

@interface PSBloodSugarViewController : UIViewController
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *bloodSugarLabel;
@property (weak, nonatomic) IBOutlet UITextField *bloodSugar;
@property (nonatomic, strong) PSUSER *user;
@property (nonatomic, strong) PSDBManager *db;

@end
