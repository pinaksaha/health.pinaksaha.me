//
//  PSUserJournal.m
//  healthio
//
//  Created by Pinak Saha on 4/12/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSUserJournal.h"

@implementation PSUserJournal

+(PSUserJournal *) initalizeWithEntryandDate:(NSString *)userEntry createdAt:(NSString *)dateTime
{
    PSUserJournal * aJournal = [[PSUserJournal alloc]init];
    
    aJournal.entry = userEntry;
    aJournal.timeStamp = dateTime;
    
    return aJournal;
}

@end
