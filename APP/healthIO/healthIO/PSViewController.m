//
//  PSViewController.m
//  healthIO
//
//  Created by Pinak Saha on 3/17/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSViewController.h"
#import "PSDabaseManager.h"
@interface PSViewController ()

@end

@implementation PSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    PSDabaseManager * newdb = [[PSDabaseManager alloc]init];
    BOOL isSucess = newdb.createDatabase;
    if(isSucess)
    {
        NSLog(@"isSucessFull");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
