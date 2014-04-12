//
//  PSUserBloodsugar.h
//  healthio
//
//  Created by Pinak Saha on 4/11/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSUserBloodsugar : NSObject

@property (nonatomic) NSInteger bloodSugarLevel;
@property (nonatomic) NSString * createdAt;


+(PSUserBloodsugar *) initalizeWithBloodSugarLevelandDat:(NSInteger) userBloodSugar createdAt:(NSString *) dateTime;
@end
