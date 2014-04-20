//
//  BloodSugarHomeViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/20/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "BloodSugarHomeViewController.h"
#import "PSBloodSugarViewController.h"
#import "PSUserBloodsugar.h"
@interface BloodSugarHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation BloodSugarHomeViewController


@synthesize user,db;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addBloodSugarSegue"]) {
        // pass user object to home vc
        PSBloodSugarViewController *homeVC = (PSBloodSugarViewController *)segue.destinationViewController;
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
    [user.bloodSugars removeAllObjects];
    [db getBloodSugarByUserid:user];
}

- (void)viewWillAppear:(BOOL)animated
{
    [user.bloodSugars removeAllObjects];
    [db getBloodSugarByUserid:user];
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
    return [user.bloodSugars count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"bloodSugarCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PSUserBloodsugar * bloodSugar = user.bloodSugars[indexPath.row];
    
    //Clean up the time stamp
    
    NSString * dateTime = bloodSugar.createdAt;
    NSArray * timestamp = [dateTime componentsSeparatedByString:@" "];
    
    NSArray * date = [timestamp[0] componentsSeparatedByString:@"-"];
    NSArray * time = [timestamp[1] componentsSeparatedByString:@":"];
    
    //NSLog(@"M: %@ D:%@",date[1],date[2]);
    //NSLog(@"H: %@ M:%@",time[0],time[1]);
    //Display in cell
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%ld",(long)bloodSugar.bloodSugarLevel]];
    [cell.textLabel setText:[NSString stringWithFormat:@"Date: %@/%@ Time: %@:%@ ",date[1],date[2],time[0],time[1]]];
    return cell;
}


- (IBAction)addBloodSugarButton:(id)sender
{
    [self performSegueWithIdentifier:@"addBloodSugarSegue" sender:user];
}
@end