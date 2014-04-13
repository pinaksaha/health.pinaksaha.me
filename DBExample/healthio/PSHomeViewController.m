//
//  PSHomeViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/9/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSHomeViewController.h"
#import "PSUSER.h"
#import "PSHeartRateViewController.h"

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
    
    result.text = self.user.username;
    NSString * user2 = self.user.username;
    NSLog(@" UserName : %@",user2);
    
    //The below code works, the database object needs to be passed
    //PSUSER *u = [db getUserByUsername:user2];
    //NSLog(@" UserNameAgain : %@",u.username);
    
    
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
    PSHeartRateViewController* heartVC = (PSHeartRateViewController*) segue.destinationViewController;
    heartVC.user = self.user;
    heartVC.db = self.db;
    
    
}

- (IBAction)LougoutButton:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
