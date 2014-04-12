//
//  PSUserBloodPressure.h
//  healthio
//
//  Created by Pinak Saha on 4/12/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSUserBloodPressure : NSObject

@property (nonatomic) NSInteger hingh;
@property (nonatomic) NSInteger low;
@property (nonatomic,strong) NSString * timeStamp;


+(PSUserBloodPressure *) initalizeWithHighLowandTimestamp:(NSInteger) userHighVlaue low:(NSInteger)userLowValue createdAt:(NSString *) dateTime;

@end
