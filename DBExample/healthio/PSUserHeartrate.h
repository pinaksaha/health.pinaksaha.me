//
//  PSUserHeartrate.h
//  healthio
//
//  Created by Pinak Saha on 4/9/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSUserHeartrate : NSObject

@property (nonatomic) NSInteger bmp;
@property (nonatomic, strong) NSString * createdAt;

+(PSUserHeartrate *) initalizeWithBMPandTimestamp:(NSInteger) userBMP createdAt:(NSString *) dateTime;

@end
