//
//  PSDabaseManager.h
//  healthIO
//
//  Created by Pinak Saha on 3/17/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface PSDabaseManager : NSObject
{
    NSString * databasePath;
}

-(BOOL) createDatabase;

@end
