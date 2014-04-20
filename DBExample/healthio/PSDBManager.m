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
            const char * create_users_table ="CREATE TABLE IF NOT EXISTS USERS(id INTEGER PRIMARY KEY AUTOINCREMENT,username VARCHAR(255) NOT NULL,pin VARCHAR(255) NOT NULL)";
            
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
        NSString * addUser = [NSString stringWithFormat:@"insert into USERS(username,pin) values('ioadmin','1234')"];
        
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
        
        NSString * insertBloodPressure = [NSString stringWithFormat:@"insert into USERS_BloodPressures(users_id,high,low,created_at) values(%i,%i,%i,datetime('now'))",(int)userID,(int)highPressure,(int)lowPressure];
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
        
        NSString * insertBloodSugar = [NSString stringWithFormat:@"insert into USERS_BloodSugars(users_id,levels,created_at) values(%i,%i,datetime('now'))",(int)userID,(int)level];
        // NSLog(@"%@",insertBloodSugar);
        
        const char * insert_statement = [insertBloodSugar UTF8String];
        
        sqlite3_prepare_v2(_conncatDB, insert_statement, -1, &statement, NULL);
        
        
        
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
        
        NSString * insertHeartrate = [NSString stringWithFormat:@"insert into USERS_HeartRate(users_id,bpm,created_at) values(%i,%i,datetime('now'))",(int)userID,(int)bmp];
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
-(void) addUserWeight:(NSInteger)userWeight userID:(NSInteger)userID
{
 
    //Insert Weight to database
    sqlite3_stmt * statement;
    const char * databasePath = [_dataBasePath UTF8String];
    
    //connect to database
    if (sqlite3_open(databasePath, &_conncatDB)== SQLITE_OK)
    {
        //Prepare statement
        
        NSString * insertUserWeight = [NSString stringWithFormat:@"insert into USERS_Weights(users_id,levels,created_at) values(%i,%i,datetime('now'))",(int)userID,(int)userWeight];
        NSLog(@"%@",insertUserWeight);
        
        const char * insert_statement = [insertUserWeight UTF8String];
        
        sqlite3_prepare_v2(_conncatDB, insert_statement, -1, &statement, NULL);
        
        //insert user weight
        
        if(sqlite3_step(statement)== SQLITE_DONE)
        {
            NSLog(@"Sucessfully inserted Weight");
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
-(void) addUserJournalEntry:(NSString *)entry userID:(NSInteger)userID
{
    //Insert Weight to database
    sqlite3_stmt * statement;
    const char * databasePath = [_dataBasePath UTF8String];
    
    //connect to database
    if (sqlite3_open(databasePath, &_conncatDB)== SQLITE_OK)
    {
        //Prepare statement
        
        NSString * insertUserEntry = [NSString stringWithFormat:@"insert into USERS_Journal(users_id,post,created_at) values(%i,\"%@\",datetime('now'))",(int)userID,entry];
        NSLog(@"%@",insertUserEntry);
        
        const char * insert_statement = [insertUserEntry UTF8String];
        
        sqlite3_prepare_v2(_conncatDB, insert_statement, -1, &statement, NULL);
        
        //insert user weight
        
        if(sqlite3_step(statement)== SQLITE_DONE)
        {
            NSLog(@"Sucessfully inserted entry");
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

-(PSUSER *) getUserByUsername:(NSString *) username
{
   
    PSUSER * aUser;
    
    const char * databsePath = [_dataBasePath UTF8String];
    sqlite3_stmt * query;
    
    //connect to database
    
    if(sqlite3_open(databsePath, &_conncatDB) == SQLITE_OK)
    {
        //connection sucessfull
        
        NSString * sqlQuery = [NSString stringWithFormat:@"select * from USERS where username = \"%@\"",username];
        const char * queryStatement = [sqlQuery UTF8String];
        
        //prepare the statement
        if(sqlite3_prepare_v2(_conncatDB, queryStatement, -1, &query, NULL) == SQLITE_OK)
        {
            //preperation is sucessfull
            
            if(sqlite3_step(query) == SQLITE_ROW)
            {
                NSString * userID = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 0)];
                NSString * userName = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 1)];
                NSString * pin = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 2)];
                aUser = [PSUSER userWithUserid:[userID intValue] username:userName];
                aUser.pin = pin;
                
            }
        }
        else
        {
            NSLog(@"Failed to prepare User get statement");
        }
    }
    sqlite3_finalize(query);
    sqlite3_close(_conncatDB);
    
    
    
    return aUser;
}


-(void) getHeartRateByUserid:(PSUSER*) user{
    
    const char * databsePath = [_dataBasePath UTF8String];
    sqlite3_stmt * query;
    
    //connect to database
    
    if(sqlite3_open(databsePath, &_conncatDB) == SQLITE_OK)
    {
        //connection sucessfull
        
        NSString * sqlQuery = [NSString stringWithFormat:@"select bpm,created_at from USERS_HeartRate where users_id  = %li  order by created_at DESC",user.userid];
        const char * queryStatement = [sqlQuery UTF8String];
        NSLog(@" %@",sqlQuery);
        //prepare the statement
        if(sqlite3_prepare_v2(_conncatDB, queryStatement, -1, &query, NULL) == SQLITE_OK)
        {
            //preperation is sucessfull
            
            while(sqlite3_step(query) == SQLITE_ROW)
            {
                NSString * temp= [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 0)];
                NSInteger heartrate = [temp intValue];
                
                NSString * time= [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 1)];
                
                PSUserHeartrate* hr = [PSUserHeartrate initalizeWithBMPandTimestamp:heartrate createdAt:time];
                [user.heartRates addObject:hr];
                
            }
        }
        else
        {
            NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
            NSLog(@"Failed to prepare User Heart Rate get statement");
        }
    }
    sqlite3_finalize(query);
    sqlite3_close(_conncatDB);
    
    

}


-(void) getWeightByUserid:(PSUSER *) user{
    
    
    
    const char * databsePath = [_dataBasePath UTF8String];
    sqlite3_stmt * query;
    
    //connect to database
    
    if(sqlite3_open(databsePath, &_conncatDB) == SQLITE_OK)
    {
        //connection sucessfull
        
        NSString * sqlQuery = [NSString stringWithFormat:@"select levels, created_at from USERS_Weights where users_id  = %li order by created_at DESC",user.userid];
        const char * queryStatement = [sqlQuery UTF8String];
        
        //prepare the statement
        if(sqlite3_prepare_v2(_conncatDB, queryStatement, -1, &query, NULL) == SQLITE_OK)
        {
            //preperation is sucessfull
            
            while(sqlite3_step(query) == SQLITE_ROW)
            {
                NSString * temp= [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 0)];
                NSInteger value = [temp intValue];
                
                NSString * time= [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 1)];
                PSUserweight* weight = [[PSUserweight initalizeWithWeightandTimestamp:value createdAt:time]init];
                //NSLog(@"Weight: %ld Timestamp: %@",(long)weight.weight,weight.timeStamp);
                [user.weights addObject:weight];
                
            }
        }
        else
        {
            NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
            NSLog(@"Failed to prepare User Weight get statement");
        }
    }
    sqlite3_finalize(query);
    sqlite3_close(_conncatDB);
    


}

-(void) getBloodPressureByUserid:(PSUSER*) user{
    
    
    const char * databsePath = [_dataBasePath UTF8String];
    sqlite3_stmt * query;
    
    //connect to database
    
    if(sqlite3_open(databsePath, &_conncatDB) == SQLITE_OK)
    {
        //connection sucessfull
        
        NSString * sqlQuery = [NSString stringWithFormat:@"select high, low, created_at from USERS_BloodPressures where users_id  = %li order by created_at DESC",user.userid];
        const char * queryStatement = [sqlQuery UTF8String];
        
        //prepare the statement
        if(sqlite3_prepare_v2(_conncatDB, queryStatement, -1, &query, NULL) == SQLITE_OK)
        {
            //preperation is sucessfull
            
            while(sqlite3_step(query) == SQLITE_ROW)
            {
                NSString * temp= [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 0)];
                NSInteger highvalue = [temp intValue];
                
                NSString * temp2= [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 1)];
                NSInteger lowvalue = [temp2 intValue];
                
                NSString * time= [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 2)];
                PSUserBloodPressure* bp = [[PSUserBloodPressure initalizeWithHighLowandTimestamp:highvalue low:lowvalue createdAt:time]init];
                [user.bloodPressures addObject:bp];
                
            }
        }
        else
        {
            NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
            NSLog(@"Failed to prepare User Blood Pressure get statement");
        }
    }
    sqlite3_finalize(query);
    sqlite3_close(_conncatDB);

}

-(void) getBloodSugarByUserid:(PSUSER*) user{
    
    
    const char * databsePath = [_dataBasePath UTF8String];
    sqlite3_stmt * query;
    
    //connect to database
    
    if(sqlite3_open(databsePath, &_conncatDB) == SQLITE_OK)
    {
        //connection sucessfull
        
        NSString * sqlQuery = [NSString stringWithFormat:@"select levels, created_at from USERS_BloodSugars where users_id  = %li order by created_at DESC",user.userid];
        const char * queryStatement = [sqlQuery UTF8String];
        
        //prepare the statement
        if(sqlite3_prepare_v2(_conncatDB, queryStatement, -1, &query, NULL) == SQLITE_OK)
        {
            //preperation is sucessfull
            
            while(sqlite3_step(query) == SQLITE_ROW)
            {
                NSString * temp= [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 0)];
                NSInteger level = [temp intValue];
                
                
                NSString * time= [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 1)];
                PSUserBloodsugar* bs = [[PSUserBloodsugar initalizeWithBloodSugarLevelandDat:level createdAt:time]init];
                [user.bloodSugars addObject:bs];
                
            }
        }
        else
        {
            NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
            NSLog(@"Failed to prepare User Blood Sugar get statement");
        }
    }
    sqlite3_finalize(query);
    sqlite3_close(_conncatDB);
    
  
}

-(void) getJournalByUserid:(PSUSER*) user{
    
    
    const char * databsePath = [_dataBasePath UTF8String];
    sqlite3_stmt * query;
    
    //connect to database
    
    if(sqlite3_open(databsePath, &_conncatDB) == SQLITE_OK)
    {
        //connection sucessfull
        
        NSString * sqlQuery = [NSString stringWithFormat:@"select post, created_at from USERS_Journal where users_id  = %li order by created_at DESC",user.userid];
        const char * queryStatement = [sqlQuery UTF8String];
        
        //prepare the statement
        if(sqlite3_prepare_v2(_conncatDB, queryStatement, -1, &query, NULL) == SQLITE_OK)
        {
            //preperation is sucessfull
            
            while(sqlite3_step(query) == SQLITE_ROW)
            {
                NSString * post= [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 0)];
                
                
                NSString * time= [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(query, 1)];
                PSUserJournal* journal =[[PSUserJournal initalizeWithEntryandDate:post createdAt:time]init];
                [user.journalEntries addObject:journal];
                
            }
        }
        else
        {
            NSLog(@" ERROR %s",sqlite3_errmsg(_conncatDB));
            NSLog(@"Failed to prepare User Journal get statement");
        }
    }
    sqlite3_finalize(query);
    sqlite3_close(_conncatDB);

 

}




@end
