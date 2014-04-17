//
//  PSBloodSugarViewController.m
//  healthio
//
//  Created by Abdul Goffar on 4/17/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSBloodSugarViewController.h"

@interface PSBloodSugarViewController ()

@end

@implementation PSBloodSugarViewController
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
    
    [self.bloodSugar resignFirstResponder];
    
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

- (IBAction)save:(id)sender {
    NSInteger temp = [self.bloodSugar.text intValue];
    [db addUserBloodSugar:temp userID:self.user.userid];
    self.bloodSugarLabel.text = self.bloodSugar.text;
    [db getBloodSugarByUserid:user];
    
}
@end
