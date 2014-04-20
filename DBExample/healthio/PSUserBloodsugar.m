//
//  PSUserBloodsugar.m
//  healthio
//
//  Created by Pinak Saha on 4/11/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSUserBloodsugar.h"

@implementation PSUserBloodsugar

+(PSUserBloodsugar *) initalizeWithBloodSugarLevelandDat:(NSInteger)userBloodSugar createdAt:(NSString *)dateTime
{
    PSUserBloodsugar * aBloodSugar = [[PSUserBloodsugar alloc]init];
    
    aBloodSugar.bloodSugarLevel = userBloodSugar;
    aBloodSugar.createdAt = dateTime;
    
    return aBloodSugar;
}

@end
