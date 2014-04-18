//
//  HeartRateHomeViewController.h
//  healthio
//
//  Created by Pinak Saha on 4/17/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSUSER.h"
#import "PSDBManager.h"
@interface HeartRateHomeViewController:UIViewController


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) PSUSER *user;
@property (nonatomic, strong) PSDBManager *db;

- (IBAction)makeNewEntry:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *HeartRateData;
@end
