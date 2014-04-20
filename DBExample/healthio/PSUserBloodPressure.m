//
//  PSUserBloodPressure.m
//  healthio
//
//  Created by Pinak Saha on 4/12/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSUserBloodPressure.h"

@implementation PSUserBloodPressure

+(PSUserBloodPressure *) initalizeWithHighLowandTimestamp:(NSInteger)userHighVlaue low:(NSInteger)userLowValue createdAt:(NSString *)dateTime
{
    PSUserBloodPressure * aBloodPressure = [[PSUserBloodPressure alloc]init];
    
    aBloodPressure.hingh = userHighVlaue;
    aBloodPressure.low = userLowValue;
    aBloodPressure.timeStamp = dateTime;
    
    return aBloodPressure;
}

@end
