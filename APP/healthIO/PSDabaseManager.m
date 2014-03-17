//
//  PSDabaseManager.m
//  healthIO
//
//  Created by Pinak Saha on 3/17/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSDabaseManager.h"

static sqlite3 * database = nil;

@implementation PSDabaseManager

-(BOOL) createDatabase
{
    NSString * dir;
    NSArray * dirpaths;
    BOOL isSucess = YES;
    
    //Documents in directory
    dirpaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    //Getting directory
    dir = dirpaths[0];
    NSLog(dir);
    //Database path
    databasePath = [[NSString alloc] initWithString:[dir stringByAppendingPathComponent:@"healthio.db"]];
    NSLog(databasePath);
    //Create the path
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    //check if database exists
    if([fileManager fileExistsAtPath:databasePath] == NO)
    {
        const char *dataBaseServerpath = [databasePath UTF8String];
        
        if(sqlite3_open(dataBaseServerpath, &database) == SQLITE_OK)
        {
            char * errorMessaage;
            
            const char * userTable = "create table if not exists iousers(id interger primary key autoincrement, usename TEXT, password TEXT, created_at datetime(), updated text)";
            if(sqlite3_exec(database, userTable, NULL, NULL, &errorMessaage) != SQLITE_OK)
            {
                isSucess = NO;
                NSLog(dir);
                NSLog(@"\nFailed to make table\n");
                NSLog(databasePath);
            }
        }
    }
    
    
    
    return isSucess;
}

@end
