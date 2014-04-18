//
//  HeartRateHomeViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/17/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "HeartRateHomeViewController.h"
#import "PSUSER.h"
#import "PSDBManager.h"
#import "PSUserHeartrate.h"
#import "PSHeartRateViewController.h"

@interface HeartRateHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation HeartRateHomeViewController

@synthesize  db, user;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addHeartRateSegue"]) {
        // pass user object to home vc
        PSHeartRateViewController *homeVC = (PSHeartRateViewController *)segue.destinationViewController;
        homeVC.user = user;
        homeVC.db = db;
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.HeartRateData.text = user.username;
    [user.heartRates removeAllObjects];
    [db getHeartRateByUserid:user];
}

- (void)viewWillAppear:(BOOL)animated
{
    [user.heartRates removeAllObjects];
    [db getHeartRateByUserid:user];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [user.heartRates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HeartRateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PSUserHeartrate *heartrate = user.heartRates[indexPath.row];
    [cell.detailTextLabel setText:heartrate.createdAt];
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld", (long)heartrate.bmp]];
    
    return cell;
}

- (IBAction)makeNewEntry:(id)sender
{
    [self performSegueWithIdentifier:@"addHeartRateSegue" sender:user];
}
@end
