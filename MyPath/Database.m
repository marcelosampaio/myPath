//
//  Database.m
//  MyPath
//
//  Created by Marcelo Sampaio on 4/30/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//


#import "Database.h"


#define DATABASE_IDENTIFIER         @"MyPath.db"

@interface Database()

@property (nonatomic,strong) Database *database;

@end


@implementation Database

@synthesize database=_database;


#pragma mark - Lazy Instantiation
- (Database *) database
{
    if(!_database)
    {
        _database = [[Database alloc] init];
    }
    return _database;
}



#pragma mark - Database Methods
-(NSString *) dbPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"database Path: %@",[[paths objectAtIndex:0] stringByAppendingPathComponent:DATABASE_IDENTIFIER]);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:DATABASE_IDENTIFIER];
}


-(void) openDB
{
    if (sqlite3_open([[self.database dbPath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"Open database failure!");
        return;
    }
}

-(void) closeDB
{
    sqlite3_close(db);
}

-(void) copyDatabaseToWritableFolder
{
    // Testa a existência de cópia editavel
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DATABASE_IDENTIFIER];
    
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
    {
        return;
    }
    
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_IDENTIFIER];

    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}


#pragma mark - Data Manipulation Methods
-(void)insertLocation:(DatabaseRow *)location {

    // Open database
    [self openDB];
    
    // Insert location into database
    // error variable for database call
    char *err;
    
    // sql string
    NSString *sql=[NSString stringWithFormat:@"insert into locations (eventType, latitude, longitude, thoroughfare, postalCode, administrativeArea, country) values (%d,%f,%f,'%@','%@','%@','%@')",location.eventType,location.latitude,location.longitude,location.thoroughfare,location.postalCode,location.administrativeArea,location.country];
    
    NSLog(@"*** SQL = %@",sql);
    
    // execute database command
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Database error - (insertLocation:) Method");
        NSLog(@"Insertion error");
    }

    
    
    // Close database
    [self closeDB];
}



@end
