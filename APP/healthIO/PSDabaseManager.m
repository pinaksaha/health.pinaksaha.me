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


-(sqlite3 *) getDatabse
{
    return database;
}
-(NSMutableString*) sqlite3StmtToString:(sqlite3_stmt*) statement
{
    NSMutableString *s = [NSMutableString new];
    [s appendString:@"{\"statement\":["];
    for (int c = 0; c < sqlite3_column_count(statement); c++){
        [s appendFormat:@"{\"column\":\"%@\",\"value\":\"%@\"}",[NSString stringWithUTF8String:(char*)sqlite3_column_name(statement, c)],[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, c)]];
        if (c < sqlite3_column_count(statement) - 1)
            [s appendString:@","];
    }
    [s appendString:@"]}"];
    return s;
}
-(BOOL) createDatabase
{
    NSString * dir;
    NSArray * dirpaths;
    BOOL isSucess = YES;
    
    //Documents in directory
    dirpaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    //Getting directory
    dir = dirpaths[0];

    //Database path
    databasePath = [[NSString alloc] initWithString:[dir stringByAppendingPathComponent:@"healthio.db"]];
 
    //Create the path
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    //check if database exists
    if([fileManager fileExistsAtPath:databasePath] == NO)
    {
        const char *dataBaseServerpath = [databasePath UTF8String];
        
        if(sqlite3_open(dataBaseServerpath, &database) == SQLITE_OK)
        {
            char * errorMessaage;
            NSLog(@"Creating the Datatabse");
            const char * userTable = "create table if not exists iousers(id interger primary key autoincrement, usename TEXT, password TEXT, created_at datetime(), updated text)";
            
            if(sqlite3_exec(database, userTable, NULL, NULL, &errorMessaage) != SQLITE_OK)
            {
                isSucess = NO;
                NSLog(@"Failed Creating the Datatabse");
            }
            else
            {
                NSLog(@"Addding admin");
                const char * addAdmin = "INSERT INTO iousers(username,password)values('admin','admin')";
                if(sqlite3_exec(database, addAdmin, NULL, NULL, &errorMessaage) != SQLITE_OK)
                {
                    isSucess = NO;
                }
                
                else
                {
                    NSLog(@"Displaying all users or trying");
                    char * showUsers = "select * from iousers";
                    
                }
            }
        }
    }
    
    
    
    return isSucess;
}

@end
