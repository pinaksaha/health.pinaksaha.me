//
//  BloodPressureHomeViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/19/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "BloodPressureHomeViewController.h"
#import "PSBloodpressureViewController.h"
#import "PSUserBloodPressure.h"
#import "PSUSER.h"
#import "PSDBManager.h"


@interface BloodPressureHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation BloodPressureHomeViewController

@synthesize user,db;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addBloodPressureSegue"]) {
        // pass user object to home vc
        PSBloodpressureViewController *homeVC = (PSBloodpressureViewController *)segue.destinationViewController;
        homeVC.user = self.user;
        homeVC.db = self.db;
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
    [user.bloodPressures removeAllObjects];
    [db getBloodPressureByUserid:user];
}

- (void)viewWillAppear:(BOOL)animated
{
    [user.bloodPressures removeAllObjects];
    [db getBloodPressureByUserid:user];
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [user.bloodPressures count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"BloodPressureCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PSUserBloodPressure * bloodPressure = user.bloodPressures[indexPath.row];
    NSLog(@"High: %ld Low: %ld",(long)bloodPressure.hingh,(long)bloodPressure.low);
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%ld",(long)bloodPressure.hingh]];
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld",(long)bloodPressure.low]];
    
    return cell;
}
- (IBAction)newEntry:(id)sender
{
    [self performSegueWithIdentifier:@"addBloodPressureSegue" sender:user];
}
@end
