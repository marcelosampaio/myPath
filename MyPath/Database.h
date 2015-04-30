//
//  Database.h
//  MyPath
//
//  Created by Marcelo Sampaio on 4/30/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "DatabaseRow.h"

@interface Database : NSObject
{
    sqlite3 *db;
}


#pragma mark - Database Methods
// open database
//-(void) openDB;
//-(void) closeDB;
-(void) copyDatabaseToWritableFolder;

#pragma mark - Data Manipulation Methods
-(void)insertLocation:(DatabaseRow *)location;

@end
