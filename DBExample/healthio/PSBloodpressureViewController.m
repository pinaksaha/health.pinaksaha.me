//
//  PSBloodpressureViewController.m
//  healthio
//
//  Created by Abdul Goffar on 4/15/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSBloodpressureViewController.h"

@interface PSBloodpressureViewController ()

@end

@implementation PSBloodpressureViewController
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
    
    [self.lowvalue resignFirstResponder];
    [self.highvalue resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

- (IBAction)saveBloodPressure:(id)sender {
    NSInteger temp = [self.lowvalue.text intValue];
    NSInteger temp2 = [self.highvalue.text intValue];
    [db addUserBloodPressure:temp2 lowPressure:temp userID:self.user.userid];
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
