//
//  PSViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/6/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSViewController.h"
#import "PSDBManager.h"
#import "PSUSER.h"
#import "PSHomeViewController.h"
#import "PSCreateProfileViewController.h"

@interface PSViewController () {
    PSDBManager * ioDB;
}

@end

@implementation PSViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"HomeSegue"]) {
        // pass user object to home vc
        PSHomeViewController *homeVC = (PSHomeViewController *)segue.destinationViewController;
        homeVC.user = sender;
        homeVC.db = ioDB;
    }
    
    if ([segue.identifier isEqualToString:@"createProfile"]) {
        PSCreateProfileViewController* createProfileVC = (PSCreateProfileViewController *) segue.destinationViewController;
        createProfileVC.db = ioDB;
    
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.username) {
        BOOL success = [self.username resignFirstResponder];
        [self.password becomeFirstResponder];
        return success;
    } else if (textField == self.password) {
        BOOL success = [self.password resignFirstResponder];
        [self sendData:nil];
        return success;
    }
    
    return NO;


}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.username.delegate=self;
    self.errorLable.text =@"";
    ioDB = [[PSDBManager alloc]init];
    [ioDB createDabase];
    if([ioDB doesUserExist:@"ioadmin"] == NO)
    {
        [ioDB makeIOAdmin];
    }
    else
    {
        NSLog(@"ioAdmin Already Exisits");
    }
    
    
        //Test code to add user to the systerm
        //int pin = 1234;
        //NSInteger * userPin = pin;
        //[ioDB addUser:@"pinaksaha" passwordPin:userPin];
    
    /*
        //Test to see if you can add blood pressure
    
    [ioDB addUserBloodPressure:(int)120 lowPressure:(int)80 userID:(int)2];
    
    */
    [ioDB viewUsers];
    //Heart rate test

    //[ioDB addUserHeartRate:120 userID:2];
    //[ioDB addUserWeight:220 userID:2];
    //[ioDB addUserJournalEntry:@"Bull shit people are such bitches" userID:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendData:(id)sender {
    //Validation before sending
    
    //PSUSER * testUser = [ioDB getUserByUsername:@"pinaksaha"];
    //[testUser displayUser];

    //[self performSegueWithIdentifier:@"HomeSegue" sender:testUser];
    
    //Tet for user name and password
    NSString * userName  = self.username.text;
    NSString * password  = self.password.text;
    
   NSLog(@"%@   => %@",userName,password);
    
    NSString * errorFlag;
    
    if([ioDB doesUserExist:userName] == YES)
    {
    
        PSUSER * loginUser = [ioDB getUserByUsername:userName];
        NSLog(@" %@ => %@",loginUser.username,userName);
        if([userName isEqualToString:loginUser.username] == YES)
        {
            NSLog(@"Checking for password");
            if([password isEqualToString:loginUser.pin] == YES)
            {
                NSLog(@"Password check sucessfill");
                NSLog(@" %@ => %@",loginUser.pin,password);
                PSUSER * session_user = [[PSUSER alloc] init];
                session_user.userid = loginUser.userid;
                session_user.username = loginUser.username;
                session_user.pin = loginUser.pin;
                
                [self performSegueWithIdentifier:@"HomeSegue" sender:session_user];
            
            }
        
            else
            {
                errorFlag = @"Username or Password is wrong";
                NSLog(@"%@ => %@",password, loginUser.pin);
                 NSLog(@"%@",errorFlag);
                self.errorLable.text = errorFlag;
                //[self performSegueWithIdentifier:@"FailSegue" sender:errorFlag];
            }
            
        }
        
        else
        {
            errorFlag = @"User dosent exist";
            NSLog(@"%@",errorFlag);
            self.errorLable.text = errorFlag;
            //[self performSegueWithIdentifier:@"FailSegue" sender:errorFlag];
        }
    }
    
    else
    {
        errorFlag = @"User dosent exist in DB";
        NSLog(@"%@",errorFlag);
        self.errorLable.text = errorFlag;
        //[self performSegueWithIdentifier:@"FailSegue" sender:errorFlag];
    }
}

@end


