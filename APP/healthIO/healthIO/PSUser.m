//
//  PSUser.m
//  healthIO
//
//  Created by Bern Dibner Library on 3/20/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSUser.h"

@implementation PSUser

-(instancetype) initUsername: (NSString*) username
                userPassword: (NSString*) pass
                    uniqueId: (int) identity{
    self = [super init];
    if(self){
        _userName = username;
        _password = pass;
        _identification = identity;
    }
    
    return self;
    
}

-(instancetype) initWithUserName:(NSString*) uname{
    self = [super init];
    if(self){
        _userName = uname;
    }
    return self;
}

-(instancetype) initWithUserId:(int) identity{
    self = [super init];
    if(self){
        _identification = identity;
    
    }
    
    return self;
}



@end
