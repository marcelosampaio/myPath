//
//  Database.m
//  MyPath
//
//  Created by Marcelo Sampaio on 4/30/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//


#import "Database.h"
#import "AppConfig.h"



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
    
    // error variable for database call
    char *err;
    
    // insert sql string
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

-(NSMutableArray *)getLocations{
    // open database
    [self openDB];
    
    NSMutableArray *locations=[[NSMutableArray alloc]init];
    
    // Get timeline from database
    NSString *sql = [NSString stringWithFormat:@"select eventType, latitude, longitude, thoroughfare, postalCode, administrativeArea, country, eventDate from locations order by id desc"];

    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        while(sqlite3_step(statement)==SQLITE_ROW)
        {
            // eventType
            char *field1 = (char *) sqlite3_column_text(statement, 0);
            NSString *stringEventType = [[NSString alloc] initWithUTF8String:field1];
            
            // latitude
            char *field2 = (char *) sqlite3_column_text(statement, 1);
            NSString *stringLatitude = [[NSString alloc] initWithUTF8String:field2];
            
            // longitude
            char *field3 = (char *) sqlite3_column_text(statement, 2);
            NSString *stringLongitude = [[NSString alloc] initWithUTF8String:field3];
            
            // thoroughfare
            char *field4 = (char *) sqlite3_column_text(statement, 3);
            NSString *stringThoroughfare = [[NSString alloc] initWithUTF8String:field4];
            
            // postalCode
            char *field5 = (char *) sqlite3_column_text(statement, 4);
            NSString *stringPostalCode = [[NSString alloc] initWithUTF8String:field5];

            // administrativeArea
            char *field6 = (char *) sqlite3_column_text(statement, 5);
            NSString *stringAdministrativeArea = [[NSString alloc] initWithUTF8String:field6];

            // country
            char *field7 = (char *) sqlite3_column_text(statement, 6);
            NSString *stringCountry = [[NSString alloc] initWithUTF8String:field7];
            
            // eventDate
            char *field8 = (char *) sqlite3_column_text(statement, 7);
            NSString *stringEventDate = [[NSString alloc] initWithUTF8String:field8];
            
            [locations addObject:[[DatabaseRow alloc]initWithEventType:[stringEventType intValue] latitude:[stringLatitude floatValue] longitude:[stringLongitude floatValue] thoroughfare:stringThoroughfare postalCode:stringPostalCode locality:stringPostalCode administrativeArea:stringAdministrativeArea country:stringCountry eventDate:stringEventDate]];
            
        } // End While
        
    }
    // Close Database
    [self closeDB];
    
    // return data
    return locations;

}

-(void)removeLocations {
    
    // Open database
    [self openDB];
    
    // error variable for database call
    char *err;
    
    // insert sql string
    NSString *sql=@"delete from locations";
    
    // execute database command
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Database error - (removeLocations:) Method");
        NSLog(@"Removal error");
    }
    
    
    
    // Close database
    [self closeDB];
}



@end
