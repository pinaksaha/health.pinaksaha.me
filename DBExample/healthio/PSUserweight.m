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
    PSUserweight * aWeight = [[PSUserweight alloc]init];
    
    aWeight.weight = userWeight;
    aWeight.timeStamp = dateTime;
    
    return aWeight;
}

@end
