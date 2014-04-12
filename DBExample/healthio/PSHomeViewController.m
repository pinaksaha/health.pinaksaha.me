//
//  PSHomeViewController.m
//  healthio
//
//  Created by Pinak Saha on 4/9/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSHomeViewController.h"
#import "PSUSER.h"

@interface PSHomeViewController ()

@end

@implementation PSHomeViewController
@synthesize result, usertext;

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
    result.text = usertext.text;
    NSString * user = usertext.text;
     NSLog(@" UserName : %@",user);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    result.text = self.user.username;
    
    
    self.navigationItem.hidesBackButton = YES;
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
- (IBAction)LougoutButton:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
