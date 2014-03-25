//
//  PSViewController.m
//  healthIO
//
//  Created by Pinak Saha on 3/17/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSViewController.h"
#import "PSDabaseManager.h"
#import <sqlite3.h>
@interface PSViewController ()

@end

@implementation PSViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    PSDabaseManager * newdb = [[PSDabaseManager alloc]init];
    BOOL isSucess = newdb.createDatabase;
    
    if(isSucess)
    {
        NSLog(@"isSucessFull");
        sqlite3 * database = newdb.getDatabse;
        char * errorMessaage;
        NSLog(@"Addding admin");
        char * addAdmin = "INSERT INTO iousers(username,password)values('admin','admin')";
        //sqlite3_exec(database, addAdmin, NULL, NULL, &errorMessaage);
        sqlite3_stmt * addUser;
        sqlite3_prepare_v2(database, addUser, -1, addAdmin, &addUser);
        sqlite3_step(addUser);
        
        
        NSLog(@"Displaying all users or trying");
        const char * displayUSers = "select * from iousers";
        sqlite3_stmt * displayStatemnt;
        sqlite3_prepare(database, displayUSers, -1, &displayStatemnt , &displayUSers);
        
        while(sqlite3_step(displayStatemnt) == SQLITE_ROW)
        {
            NSString * primaryKey = [NSString stringWithUTF8String:(char *) sqlite3_column_text(displayStatemnt, 0)];
            NSLog(primaryKey);
        }
        
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
