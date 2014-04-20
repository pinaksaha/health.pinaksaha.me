//
//  BloodPressureHomeViewController.h
//  healthio
//
//  Created by Pinak Saha on 4/19/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSUSER.h"
#import "PSDBManager.h"

@interface BloodPressureHomeViewController : UIViewController

@property (nonatomic, strong) PSUSER *user;
@property (nonatomic, strong) PSDBManager *db;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)newEntry:(id)sender;

@end
