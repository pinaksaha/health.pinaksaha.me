//
//  PSDBManager.m
//  healthio
//
//  Created by Pinak Saha on 4/6/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import "PSDBManager.h"




@implementation PSDBManager


-(void) createDabase
{
    NSString * documentDirectory;
    NSArray * directoryPaths;
    
    //Getting document Diectory
    
    directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentDirectory = directoryPaths[0];
    
    //Building database bath
    
    _dataBasePath = [[NSString alloc] initWithString:[documentDirectory stringByAppendingPathComponent:@"healthio.db"]];
    
    NSFileManager * databaseFileManager = [NSFileManager defaultManager];
    
    if([databaseFileManager fileExistsAtPath:_dataBasePath] == NO)
    {
        const char * databasePath = [_dataBasePath UTF8String];
        
        if(sqlite3_open(databasePath, &_conncatDB) == SQLITE_OK)
        {
           //create the schema
            char * errorMsg;
            const char * create_users_table ="CREATE TABLE IF NOT EXISTS USERS(id INTEGER PRIMARY KEY AUTOINCREMENT,username VARCHAR(255) NOT NULL,pin INTEGER NOT NULL)";
            
            const char * create_users_bloodPressures_table ="CREATE TABLE IF NOT EXISTS USERS_BloodPressures(id INTEGER PRIMARY KEY AUTOINCREMENT,users_id INTEGER NOT NULL,high INTEGER NOT NULL,low INTEGER NOT NULL,created_at TIMESTAMP NOT NULL,FOREIGN KEY (users_id) REFERENCES USERS(id))";
            
            const char * create_users_bloodSugars_table ="CREATE TABLE IF NOT EXISTS USERS_BloodSugars(id INTEGER PRIMARY KEY AUTOINCREMENT,users_id INTEGER NOT NULL,levels  INTEGER NOT NULL,created_at TIMESTAMP NOT NULL,FOREIGN KEY (users_id) REFERENCES USERS(id))";
            
            const char * create_users_weight_table = "CREATE TABLE IF NOT EXISTS USERS_Weights(id INTEGER PRIMARY KEY AUTOINCREMENT,users_id INTEGER NOT NULL,levels  INTEGER NOT NULL,created_at TIMESTAMP NOT NULL,FOREIGN KEY (users_id) REFERENCES USERS(id))";
            const char * create_users_heartRates_table = "CREATE TABLE IF NOT EXISTS USERS_HeartRate(id INTEGER PRIMARY KEY AUTOINCREMENT,users_id INTEGER NOT NULL,bpm  INTEGER NOT NULL,created_at TIMESTAMP NOT NULL,FOREIGN KEY (users_id) REFERENCES USERS(id))";
            const char * create_users_jounals_table = "CREATE TABLE IF NOT EXISTS USERS_Journal(id INTEGER PRIMARY KEY AUTOINCREMENT,users_id INTEGER NOT NULL,post  VARCHAR(2048) NOT NULL,created_at TIMESTAMP NOT NULL,FOREIGN KEY (users_id) REFERENCES USERS(id))";
            
            
                if(sqlite3_exec(_conncatDB, create_users_table, NULL, NULL, &errorMsg)!= SQLITE_OK)
                {
                    NSLog(@"Failed to make user table");
                }
            
                if(sqlite3_exec(_conncatDB, create_users_bloodPressures_table, NULL, NULL, &errorMsg)!= SQLITE_OK)
                {
                    NSLog(@"Failed to make blood pressure table");
                }
                if(sqlite3_exec(_conncatDB, create_users_bloodSugars_table, NULL, NULL, &errorMsg)!= SQLITE_OK)
                {
                    NSLog(@"Failed to make blood sugars table");
                }
            
                if(sqlite3_exec(_conncatDB, create_users_weight_table, NULL, NULL, &errorMsg)!= SQLITE_OK)
                {
                    NSLog(@"Failed to make weight table");
                }
                if(sqlite3_exec(_conncatDB, create_users_heartRates_table, NULL, NULL, &errorMsg)!= SQLITE_OK)
                {
                    NSLog(@"Failed to make heart rate table");
                }
            
                if(sqlite3_exec(_conncatDB, create_users_jounals_table, NULL, NULL, &errorMsg)!= SQLITE_OK)
                {
                    NSLog(@"Failed to make Journals table");
                }
            
            NSLog(@"Sucessfuly Created Database");
        }
        
        else
        {
            NSLog(@"Failed to open/Cretae database");
        }
    }
    else
    {
        NSLog(@"Database already exists");
    }
    sqlite3_close(_conncatDB);
}

-(void) makeIOAdmin
{
    sqlite3_stmt * statement;
    const char * databasePath = [_dataBasePath UTF8String];
    
    //connect to database
    if(sqlite3_open(databasePath,&_conncatDB) == SQLITE_OK)
    {
        
        //Prepare the statement
        NSString * addUser = [NSString stringWithFormat:@"insert into USERS(username,pin) values('ioadmin',1234)"];
        
        const char * insert_statement = [addUser UTF8String];
        
        sqlite3_prepare_v2(_conncatDB, insert_statement, -1, &statement, NULL);
        
        //Insert the user
        
        if(sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Sucfully added root user");
        }
        
        else
        {
            NSLog(@"Insert failed, root user not added");
        }
        
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(_conncatDB);
}


-(void) viewUsers
{
    const char * databsePath = [_dataBasePath UTF8String];
    sqlite3_stmt * query;
    
    //connect to database

    if(sqlite3_open(databsePath, &_conncatDB) == SQLITE_OK)
    {
        //connection sucessfull
        
        NSString * sqlQuery = [NSString stringWithFormat:@"select * from USERS"];
        const char * queryStatement = [sqlQuery UTF8String];
        
        //prepare the statement
        if(sqlite3_prepare_v2(_conncatDB, queryStatement, -1, &query, NULL) == SQLITE_OK)
        {
            //preperation is sucessfull
            
            while(sqlite3_step(query) == SQLITE_ROW)
            {
                NSString * userID = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 0)];
                NSLog(@"%@",userID);
                
                NSString * userName = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 1)];
                NSLog(@"%@",userName);
                
                NSString * pin = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 2)];
                NSLog(@"%@",pin);
            }
            /*
            else
            {
                NSLog(@"Query failed");
            }
            */
        }
        else
        {
            NSLog(@"Prepare Statement Failed");
        }
        
    }
    else
    {
        NSLog(@"Failed to connect to DB");
    }
    sqlite3_finalize(query);
    sqlite3_close(_conncatDB);
}



-(BOOL)doesUserExist:(NSString *)username
{
    BOOL userExists = NO;
    
    
    const char * databsePath = [_dataBasePath UTF8String];
    sqlite3_stmt * query;
    
    //connect to database
    
    if(sqlite3_open(databsePath, &_conncatDB) == SQLITE_OK)
    {
        //connection sucessfull
        
        NSString * sqlQuery = [NSString stringWithFormat:@"select username from USERS where username = \"%@\"",username];
        const char * queryStatement = [sqlQuery UTF8String];
        
        //prepare the statement
        if(sqlite3_prepare_v2(_conncatDB, queryStatement, -1, &query, NULL) == SQLITE_OK)
        {
            //preperation is sucessfull
            
            if(sqlite3_step(query) == SQLITE_ROW)
            {
                userExists = YES;
            }
        }
        else
        {
            NSLog(@"Failed to prepare User get statement");
        }
    }
    sqlite3_finalize(query);
    sqlite3_close(_conncatDB);
    return userExists;
}


-(void) addUser:(NSString *)username passwordPin:(NSInteger)pin
{
    
    if([self doesUserExist:username])
    {
        //throw an error username has been take
        NSLog(@"Username %@ already exisits",username);
    }
    
    else
    {
        // Addd the user to databse
        sqlite3_stmt * statement;
        const char * databasePath = [_dataBasePath UTF8String];
        
        //connect to database
        if(sqlite3_open(databasePath,&_conncatDB) == SQLITE_OK)
        {
            
            //Prepare the statement
            
            NSString * addUser = [NSString stringWithFormat:@"insert into USERS(username,pin) values(\"%@\",%d)",username,(int)pin];
            
            //NSLog(@"%@",addUser);
            
            const char * insert_statement = [addUser UTF8String];
            
            sqlite3_prepare_v2(_conncatDB, insert_statement, -1, &statement, NULL);
            
            //Insert the user
            
            if(sqlite3_step(statement) == SQLITE_DONE)
            {
                
                NSLog(@"Sucfully added %@ user",username);
            }
            
            else
            {
                NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
                NSLog(@"Insert failed, user %@ not added",username);
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(_conncatDB);

        }

        
    }
}

-(void)addUserBloodPressure:(NSInteger)highPressure lowPressure:(NSInteger)lowPressure userID:(NSInteger)userID
{
    // Insert Bloodppressure to database
    sqlite3_stmt * statement;
    const char * databasePath = [_dataBasePath UTF8String];
    
    //Connect to database
    
    if(sqlite3_open(databasePath, &_conncatDB) == SQLITE_OK)
    {
        //prepare the statment
        
        NSString * insertBloodPressure = [NSString stringWithFormat:@"insert into USERS_BloodPressures(users_id,high,low,created_at) values(%i,%i,%i,time())",(int)userID,(int)highPressure,(int)lowPressure];
       // NSLog(@"%@",insertBloodPressure);
        
        const char * insert_statement = [insertBloodPressure UTF8String];
        
        sqlite3_prepare_v2(_conncatDB, insert_statement, -1, &statement, NULL);
        
        //Inset the blood pressure
        
        if(sqlite3_step(statement)== SQLITE_DONE)
        {
            NSLog(@"Sucessfully added Blood Pressure");
        }
        
        else
        {
            NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
            NSLog(@"Failed to Insert Blood Pressure");
        }
    }
    
    else
    {
        NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
        NSLog(@"Failed to Connect to database");
    }
    sqlite3_finalize(statement);
    sqlite3_close(_conncatDB);
}

-(void)addUserBloodSugar:(NSInteger)level userID:(NSInteger)userID
{
   
    // Insert Bloodsugar level to database
    sqlite3_stmt * statement;
    const char * databasePath = [_dataBasePath UTF8String];
    
    //Connect to database
    
    if(sqlite3_open(databasePath, &_conncatDB) == SQLITE_OK)
    {
        //prepare the statment
        
        NSString * insertBloodSugar = [NSString stringWithFormat:@"insert into USERS_BloodSugars(users_id,levels,created_at) values(%i,%i,time())",(int)userID,(int)level];
        // NSLog(@"%@",insertBloodSugar);
        
        const char * insert_statement = [insertBloodSugar UTF8String];
        
        sqlite3_prepare_v2(_conncatDB, insert_statement, -1, &statement, NULL);
        
        //Inset the blood pressure
        
        if(sqlite3_step(statement)== SQLITE_DONE)
        {
            NSLog(@"Sucessfully added Blood Sugar Levels");
        }
        
        else
        {
            NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
            NSLog(@"Failed to Insert Blood Sugar Levels");
        }
    }
    
    else
    {
        NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
        NSLog(@"Failed to Connect to database");
    }
    sqlite3_finalize(statement);
    sqlite3_close(_conncatDB);
}

-(void)addUserHeartRate:(NSInteger)bmp userID:(NSInteger)userID
{
    //Insert Heart rate to database
    sqlite3_stmt * statement;
    const char * databasePath = [_dataBasePath UTF8String];
    
    //connect to database
    if (sqlite3_open(databasePath, &_conncatDB)== SQLITE_OK)
    {
        //Prepare statement
        
        NSString * insertHeartrate = [NSString stringWithFormat:@"insert into USERS_HeartRate(users_id,bpm,created_at) values(%i,%i,time())",(int)userID,(int)bmp];
        NSLog(@"%@",insertHeartrate);
        
        const char * insert_statement = [insertHeartrate UTF8String];
        
        sqlite3_prepare_v2(_conncatDB, insert_statement, -1, &statement, NULL);
        
        //insert blood sugar
        
        if(sqlite3_step(statement)== SQLITE_DONE)
        {
            NSLog(@"Sucessfully inserted Heart rate");
        }
        
        else
        {
            NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
            NSLog(@"Failed to Connect to database");
        }
        
    }
    
    else
    {
        NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
        NSLog(@"Failed to Connect to database");
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(_conncatDB);
    
}

@end
