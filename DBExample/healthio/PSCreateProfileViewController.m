//
//  PSCreateProfileViewController.m
//  healthio
//
//  Created by Javlon Usmanov on 4/15/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSCreateProfileViewController.h"
#import "PSUSER.h"
#import "PSHomeViewController.h"
@interface PSCreateProfileViewController ()

@end

@implementation PSCreateProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"RegisterSegue"]) {
        // pass user object to home vc
        PSHomeViewController *homeVC = (PSHomeViewController *)segue.destinationViewController;
        homeVC.user = sender;
        homeVC.db = self.db;
    }

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.userName) {
        BOOL success = [self.userName resignFirstResponder];
        [self.password becomeFirstResponder];
        return success;
    }
    else if (textField == self.password) {
        BOOL success = [self.password resignFirstResponder];
        return success;
    }
    
    else if (textField == self.reEnterPasswordValue) {
        BOOL success = [self.reEnterPasswordValue resignFirstResponder];
        return success;
    }
    
    return NO;
    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.errorLabel.text = @"";
    self.userName.delegate=self;
    self.password.delegate=self;
    self.reEnterPasswordValue.delegate=self;
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
    
    NSString* userName = self.userName.text;
    NSString* passWord = self.password.text;
    NSString* reEnteredPassword = self.reEnterPasswordValue.text;
    
    //If username does not exist
    if(![self.db doesUserExist:userName]){
        
        if([passWord isEqualToString:reEnteredPassword]){
            [self.db addUser:userName passwordPin:[passWord intValue]];
            
            NSLog(@" Successful");
            PSUSER * newUser = [self.db getUserByUsername:userName];
            [self performSegueWithIdentifier:@"RegisterSegue" sender:newUser];

        }
        else{
            self.errorLabel.text = @"Passwords donot match";
        
        }
    }
    
    else{
        self.errorLabel.text = @"Username is taken.";
        
    
    }
    
}
@end
