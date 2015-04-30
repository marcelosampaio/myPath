//
//  DatabaseRow.h
//  MyPath
//
//  Created by Marcelo Sampaio on 4/30/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseRow : NSObject

@property int eventType;
@property float latitude;
@property float longitude;
@property (nonatomic,strong) NSString *thoroughfare;
@property (nonatomic,strong) NSString *postalCode;
@property (nonatomic,strong) NSString *locality;
@property (nonatomic,strong) NSString *administrativeArea;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *eventDate;

- (id)initWithEventType:(int)p_EventType latitude:(float)p_Latitude longitude:(float)p_Longitude thoroughfare:(NSString *)p_Thoroughfare postalCode:(NSString *)p_PostalCode locality:(NSString *)p_Locality administrativeArea:(NSString *)p_AdministrativeArea country:(NSString *)p_Country eventDate:(NSString *)p_EventDate;



@end
