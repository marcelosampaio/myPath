//
//  DatabaseRow.m
//  MyPath
//
//  Created by Marcelo Sampaio on 4/30/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "DatabaseRow.h"

@implementation DatabaseRow

@synthesize eventDate,eventType,latitude,longitude,thoroughfare,postalCode,locality,administrativeArea,country;

- (id)initWithEventType:(int)p_EventType latitude:(float)p_Latitude longitude:(float)p_Longitude thoroughfare:(NSString *)p_Thoroughfare postalCode:(NSString *)p_PostalCode locality:(NSString *)p_Locality administrativeArea:(NSString *)p_AdministrativeArea country:(NSString *)p_Country eventDate:(NSString *)p_EventDate
{
    self = [super init];
    if (self) {
        eventType=p_EventType;
        latitude=p_Latitude;
        longitude=p_Longitude;
        thoroughfare=p_Thoroughfare;
        postalCode=p_PostalCode;
        locality=p_Locality;
        administrativeArea=p_AdministrativeArea;
        country=p_Country;
        eventDate=p_EventDate;
    }
    return self;
}






@end
