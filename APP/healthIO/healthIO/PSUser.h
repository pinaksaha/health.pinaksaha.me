//
//  PSUser.h
//  healthIO
//
//  Created by Bern Dibner Library on 3/20/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSBloodPressure.h"
#import "PSBloodSugar.h"
#import "PSWeight.h"
#import "PSJournal.h"
#import "PSJournal.h"
#import "PSHeartRate.h"


@interface PSUser : NSObject
@property(nonatomic) NSString* userName;
@property(nonatomic) int identification;
@property(nonatomic) NSString* password;
@property(strong, nonatomic) NSMutableArray* bloodSugar;
@property(strong, nonatomic) NSMutableArray* bloodPressure;
@property(strong, nonatomic) NSMutableArray* weight;
@property(strong, nonatomic) NSMutableArray* journal;
@property(strong, nonatomic) NSMutableArray* heartWeight;
-(void) addBloodPressure:(PSBloodPressure*) bloodPressure;
-(void) addBloodSugar:(PSBloodSugar*) bloodSugar;
-(void) addWeight:(PSWeight*) weight;
-(void) addJournal:(PSJournal*) journalEntry;
-(void) addHeartRate:(PSHeartRate*) heartRate;

@end
