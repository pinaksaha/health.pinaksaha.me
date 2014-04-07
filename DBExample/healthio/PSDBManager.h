//
//  PSDBManager.h
//  healthio
//
//  Created by Pinak Saha on 4/6/14.
//  Copyright (c) 2014 Pinak Saha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface PSDBManager : NSObject

@property (strong,nonatomic) NSString * dataBasePath;
@property (nonatomic) sqlite3 *conncatDB;


-(void) createDabase;
-(void) viewUsers;
-(void) makeIOAdmin;
-(BOOL) doesUserExist :(NSString *) username;
@end

