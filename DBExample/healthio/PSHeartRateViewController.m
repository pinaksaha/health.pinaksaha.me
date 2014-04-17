//
//  PSHeartRateViewController.m
//  healthio
//
//  Created by Abdul Goffar on 4/13/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSHeartRateViewController.h"

@interface PSHeartRateViewController ()

@end

@implementation PSHeartRateViewController
@synthesize  db, user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




-(void)touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.value resignFirstResponder];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.value.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveHeartRate:(id)sender {
    
    NSInteger temp = [self.value.text intValue];
    [db addUserHeartRate:temp userID:self.user.userid];
    self.heartRate.text = self.value.text;
    [db getHeartRateByUserid:user];
   

   
    
}
@end
