//
//  WeightHomeViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/20/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "WeightHomeViewController.h"
#import "PSWeightViewController.h"
#import "PSUserweight.h"
@interface WeightHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation WeightHomeViewController 

@synthesize user,db;


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addWeightSegue"]) {
        // pass user object to home vc
        PSWeightViewController *homeVC = (PSWeightViewController *)segue.destinationViewController;
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
    [user.weights removeAllObjects];
    [db getWeightByUserid:user];
}

- (void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
    [user.weights removeAllObjects];
    [db getWeightByUserid:user];
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
    return [user.weights count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"weightCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    PSUserweight * Weights = user.weights[indexPath.row];
    NSString * dateTime = Weights.timeStamp;
    NSArray * timestamp = [dateTime componentsSeparatedByString:@" "];
    
    NSArray * date = [timestamp[0] componentsSeparatedByString:@"-"];
    //NSArray * time = [timestamp[1] componentsSeparatedByString:@":"];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"Date: %@/%@",date[1],date[2]]];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%ld",(long)Weights.weight]];
    
    return cell;
}



- (IBAction)addWeightButton:(id)sender
{
    [self performSegueWithIdentifier:@"addWeightSegue" sender:user];
}
@end
