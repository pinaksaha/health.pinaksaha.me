//
//  PSUserweight.m
//  healthio
//
//  Created by Pinak Saha on 4/12/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSUserweight.h"

@implementation PSUserweight

+(PSUserweight *) initalizeWithWeightandTimestamp:(NSInteger)userWeight createdAt:(NSString *)dateTime
{
    PSUserweight * aWight = [[PSUserweight alloc]init];
    
    aWight.weight = userWeight;
    aWight.timeStamp = dateTime;
    
    return aWight;
}

@end
