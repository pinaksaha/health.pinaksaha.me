//
//  PSHomeViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/9/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSHomeViewController.h"
#import "PSUSER.h"
#import "BloodSugarHomeViewController.h"
#import "HeartRateHomeViewController.h"

#import "WeightHomeViewController.h"
#import "BloodPressureHomeViewController.h"
#import "PSBloodPressureViewController.h"
#import "PSWeightViewController.h"
#import "PSBloodSugarViewController.h"

@interface PSHomeViewController ()

@end

@implementation PSHomeViewController
@synthesize result, usertext, db, user;

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
    
    _userName.text = self.user.username;
    NSString * user2 = self.user.username;
    NSLog(@" UserName : %@",user2);
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"HearRateViewSegue"]){
        HeartRateHomeViewController* heartVC = (HeartRateHomeViewController*) segue.destinationViewController;
        heartVC.user = self.user;
        heartVC.db = self.db;
    }
    
    if([segue.identifier isEqualToString:@"BloodPressureViewSegue"])
    {
        BloodPressureHomeViewController * bloodPressureVC = (BloodPressureHomeViewController *) segue.destinationViewController;
        bloodPressureVC.user = self.user;
        bloodPressureVC.db = self.db;
    }
    
    
    if([segue.identifier isEqualToString:@"WeightHomeSegue"])
    {
        WeightHomeViewController * weightVC = (WeightHomeViewController *) segue.destinationViewController;
        weightVC.user = self.user;
        weightVC.db = self.db;
    }
    
    
    if([segue.identifier isEqualToString:@"bloodSugarHomeSegue"])
    {
        BloodSugarHomeViewController * bloodSugarVC = (BloodSugarHomeViewController *) segue.destinationViewController;
        bloodSugarVC.user = self.user;
        bloodSugarVC.db = self.db;
    }
     
}



- (IBAction)heartRateButton:(id)sender
{
    PSUSER * sessionUser = self.user;
    NSLog(@" %@",sessionUser.username);
    [self performSegueWithIdentifier:@"HearRateViewSegue" sender:sessionUser];
}

- (IBAction)bloodPressureButton:(id)sender
{
    PSUSER * sessionUser = self.user;
    NSLog(@" %@",sessionUser.username);
    [self performSegueWithIdentifier:@"BloodPressureViewSegue" sender:sessionUser];
}

- (IBAction)weightButton:(id)sender
{
    PSUSER * sessionUser = self.user;
    NSLog(@" %@",sessionUser.username);
    [self performSegueWithIdentifier:@"WeightHomeSegue" sender:sessionUser];
}

- (IBAction)bloodSugarButton:(id)sender
{
    PSUSER * sessionUser = self.user;
    NSLog(@" %@",sessionUser.username);
    [self performSegueWithIdentifier:@"bloodSugarHomeSegue" sender:sessionUser];
}

- (IBAction)logOutButton:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}







@end
