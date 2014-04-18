//
//  PSUSER.m
//  healthio
//
//  Created by Pinak Saha on 4/9/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSUSER.h"

@implementation PSUSER


-(void) displayUser
{
    NSLog(@"Userid: %li => UserName : %@",_userid,_username);
}

+(PSUSER *) userWithUserid:(NSInteger)userID username:(NSString *)name
{
    PSUSER * aUser = [[PSUSER alloc]init];
    
    aUser.userid = userID;
    aUser.username = name;
    aUser.heartRates = [[NSMutableArray alloc]init];
    return aUser;
}

-(void) addUserHeartrate:(PSUserHeartrate *)heartRate
{
    [self.heartRates addObject:heartRate];
}

-(void) addUserBloodPressure:(PSUserBloodPressure *)bloddPressure
{
    [self.bloodPressures addObject:bloddPressure];
}

-(void) addUserbloodSugar:(PSUserBloodsugar *)bloodSugar
{
    [self.bloodSugars addObject:bloodSugar];
}


@end
