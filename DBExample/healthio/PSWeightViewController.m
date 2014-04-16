//
//  PSWeightViewController.m
//  healthio
//
//  Created by Abdul Goffar on 4/15/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSWeightViewController.h"

@interface PSWeightViewController ()

@end

@implementation PSWeightViewController
@synthesize weight, db, user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.weight) {
        BOOL success = [self.weight resignFirstResponder];
        return success;
        
    }
    return NO;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

- (IBAction)save:(id)sender {
    NSInteger temp = [self.weight.text intValue];
    [db addUserWeight:temp userID:self.user.userid];
    self.weightLabel.text = self.weight.text;
    [db getWeightByUserid:self.user];
    
    
}
@end
