//
//  PSUserJournal.h
//  healthio
//
//  Created by Pinak Saha on 4/12/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSUserJournal : NSObject

@property (nonatomic,strong) NSString * entry;
@property (nonatomic,strong) NSString * timeStamp;



+(PSUserJournal *) initalizeWithEntryandDate:(NSString *) userEntry createdAt:(NSString *) dateTime;
@end
