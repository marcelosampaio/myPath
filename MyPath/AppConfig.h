//
//  AppConfig.h
//  MyPath
//
//  Created by Marcelo Sampaio on 5/1/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#ifndef MyPath_AppConfig_h
#define MyPath_AppConfig_h

#pragma mark - String Constants

#define DEFAULT_STRING_START_ACTION                 @"S T A R T"
#define DEFAULT_STRING_STOP_ACTION                  @"S T O P"
#define DEFAULT_STRING_SHOW_LOCATIONS_ACTION        @"Locations"
#define DEFAULT_STRING_SHOW_ANIMATIONS_ACTION       @"Anima"



#pragma mark - MapKit Constants

#define DEFAULT_MAPKIT_MAXSPAN                  0.025f
#define DEFAULT_MAPKIT_DISTANCE_FROM_CENTER     800.0


#pragma mark - Device Information
#define DEFAULT_SMALL_SCREEN_SIZE_DEVICE        480



#pragma mark - Color Constants

#define DEFAULT_COLOR_GREEN                     [UIColor colorWithRed:0.1f green:0.75f blue:0.1f alpha:1.00f];
#define DEFAULT_COLOR_GREEN_ALPHA               [UIColor colorWithRed:0.1f green:0.75f blue:0.1f alpha:0.25f];
#define DEFAULT_COLOR_RED                       [UIColor colorWithRed:1.0f green:0.15f blue:0.15f alpha:1.00f];
#define DEFAULT_COLOR_RED_ALPHA                 [UIColor colorWithRed:1.0f green:0.15f blue:0.15f alpha:0.25f];
#define DEFAULT_COLOR_LOCATIONS_OUTLET          [UIColor colorWithRed:0.1f green:0.3f blue:0.05f alpha:1.00f];
#define DEFAULT_COLOR_ANIMATION_OUTLET          [UIColor colorWithRed:0.5f green:0.4f blue:0.01f alpha:1.00f];



#pragma mark - Database Constants

#define DATABASE_IDENTIFIER                     @"MyPath.db"


#endif
