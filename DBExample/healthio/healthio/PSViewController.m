//
//  PSViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/6/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSViewController.h"
#import "PSDBManager.h"
@interface PSViewController ()

@end

@implementation PSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    PSDBManager * ioDB = [[PSDBManager alloc]init];
    [ioDB createDabase];
    if([ioDB doesUserExist:@"ioadmin"] == NO)
    {
        [ioDB makeIOAdmin];
    }
    else
    {
        NSLog(@"ioAdmin Already Exisits");
    }
    
    /*
        //Test code to add user to the systerm
        int pin = 1234;
        NSInteger * userPin = pin;
        [ioDB addUser:@"pinaksaha" passwordPin:userPin];
    */
    /*
        //Test to see if you can add blood pressure
    
    [ioDB addUserBloodPressure:(int)120 lowPressure:(int)80 userID:(int)2];
    
    */
    //[ioDB viewUsers];
    //Heart rate test

    //[ioDB addUserHeartRate:120 userID:2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
