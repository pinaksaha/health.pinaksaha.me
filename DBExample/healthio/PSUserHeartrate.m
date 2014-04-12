//
//  PSUserHeartrate.m
//  healthio
//
//  Created by Pinak Saha on 4/9/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSUserHeartrate.h"

@implementation PSUserHeartrate

+(PSUserHeartrate *) initalizeWithBMPandTimestamp:(NSInteger)userBMP createdAt:(NSString *)dateTime
{
    PSUserHeartrate * userHeartrate = [[PSUserHeartrate alloc] init];
    
    userHeartrate.bmp = userBMP;
    userHeartrate.createdAt = dateTime;
    
    return userHeartrate;
}

@end
