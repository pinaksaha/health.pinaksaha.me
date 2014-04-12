//
//  PSDBManager.h
//  healthio
//
//  Created by Pinak Saha on 4/6/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "PSUserHeartrate.h"
#import "PSUSER.h"



@class PSUSER;

@interface PSDBManager : NSObject

@property (strong,nonatomic) NSString * dataBasePath;
@property (nonatomic) sqlite3 *conncatDB;

//View Methods
-(void) viewUsers;

//Inset Methods
-(void) createDabase;
-(void) makeIOAdmin;
-(BOOL) doesUserExist :(NSString *) username;
-(void) addUser:(NSString *)username passwordPin:(NSInteger) pin;
-(void) addUserBloodSugar:(NSInteger) level userID:(NSInteger) userID;
-(void) addUserWeight:(NSInteger) userWeight userID:(NSInteger) userID;
-(void) addUserBloodPressure:(NSInteger) highPressure lowPressure:(NSInteger) lowPressure userID:(NSInteger) userID;
-(void) addUserHeartRate:(NSInteger) bmp userID:(NSInteger) userID;
-(void) addUserJournalEntry:(NSString *) entry userID:(NSInteger) userID;

//Get Methods
-(PSUSER *) getUserByUsername:(PSUSER *) user;
-(void) getWeightByUserid:(PSUSER *) user;
-(void) getBloodPressureByUserid:(PSUSER *) user;
-(void) getBloodSugarByUserid:(PSUSER *) user;
-(void) getHeartRateByUserid:(PSUSER *) user;
-(void) getJournalByUserid:(PSUSER *) user;



@end

