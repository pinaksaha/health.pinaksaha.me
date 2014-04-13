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

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.value) {
        BOOL success = [self.value resignFirstResponder];
        return success;
        
    }
    return NO;
    
    //return [textField resignFirstResponder];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Below code confirms that person object is passed
    
    //NSString * user2 = self.user.username;
    //NSLog(@" UserNameinHeart : %@",user2);
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
    //add the heart rate to database
    //display heart rate in label for testing
    NSInteger temp = [self.value.text intValue];
    [db addUserHeartRate:temp userID:self.user.userid];
    self.heartRate.text = self.value.text; //Successful inserts. Watch the console.
    
   [db getHeartRateByUserid:user];
    //Having trouble displaying the heart rate array due to casting issues.

   
  
   

    
}
@end
