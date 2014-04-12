//
//  PSUserweight.h
//  healthio
//
//  Created by Pinak Saha on 4/12/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSUserweight : NSObject

@property (nonatomic) NSInteger weight;
@property (nonatomic,strong) NSString * timeStamp;

+(PSUserweight *) initalizeWithWeightandTimestamp:(NSInteger) userWeight createdAt:(NSString *) dateTime;

@end
