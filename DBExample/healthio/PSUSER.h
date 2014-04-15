//
//  PSUSER.h
//  healthio
//
//  Created by Pinak Saha on 4/9/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSDBManager.h"
#import "PSUserJournal.h"
#import "PSUserBloodPressure.h"
#import "PSUserweight.h"
#import "PSUserHeartrate.h"
#import "PSUserBloodsugar.h"


@interface PSUSER : NSObject

@property (nonatomic) NSInteger userid;
@property (nonatomic,strong) NSString * username;
@property (nonatomic,strong) NSString * pin;

//Collections

@property (nonatomic,strong) NSMutableArray * heartRates;
@property (nonatomic,strong) NSMutableArray * bloodPressures;
@property (nonatomic,strong) NSMutableArray * bloodSugars;
@property (nonatomic,strong) NSMutableArray * weights;
@property (nonatomic,strong) NSMutableArray * journalEntries;

//display methods

-(void) displayUser;

//Get Methods Declarations
//-(void)getUserBlloodPressures;



//construct user
+(PSUSER *) userWithUserid:(NSInteger)userID username:(NSString *)name;


//Insert Methods

-(void) addUserHeartrate: (PSUserHeartrate *) heartRate;
-(void) addUserBloodPressure: (PSUserBloodPressure *) bloddPressure;
-(void) addUserbloodSugar:(PSUserBloodsugar *) bloodSugar;


@end
