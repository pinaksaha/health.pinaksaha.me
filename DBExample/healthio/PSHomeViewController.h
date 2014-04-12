//
//  PSHomeViewController.h
//  healthio
//
//  Created by Pinak Saha on 4/9/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSUSER;

@interface PSHomeViewController : UIViewController{
    UITextField* usertext;
}

@property (nonatomic, strong) PSUSER *user;

@property (strong, nonatomic) IBOutlet UILabel *result;
@property (strong, nonatomic) IBOutlet UITextField* usertext;

@end
