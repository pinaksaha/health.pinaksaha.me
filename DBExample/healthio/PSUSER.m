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
    NSLog(@"Userid: %@ => UserName : %@",_userid,_username);
}

+(PSUSER *) userWithUserid:(NSInteger)userID username:(NSString *)name
{
    PSUSER * aUser = [[PSUSER alloc]init];
    
    aUser.userid = userID;
    aUser.username = name;
    
    return aUser;
}

@end
