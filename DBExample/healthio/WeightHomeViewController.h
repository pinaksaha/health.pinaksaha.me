//
//  WeightHomeViewController.h
//  healthio
//
//  Created by Pinak Saha on 4/20/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSUSER.h"
#import "PSDBManager.h"
#import "PSWeightViewController.h"
@interface WeightHomeViewController : UIViewController

@property (nonatomic, strong) PSUSER *user;
@property (nonatomic, strong) PSDBManager *db;

- (IBAction)addWeightButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
