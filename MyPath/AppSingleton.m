//
//  AppSingleton.m
//  MyPath
//
//  Created by Marcelo Sampaio on 5/28/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "AppSingleton.h"

@implementation AppSingleton

@synthesize timelineControl;

static AppSingleton *instance = nil;

#pragma mark Singleton

+ (AppSingleton *) instance
{
    @synchronized([AppSingleton class])
    {
        if (instance == nil) {
            instance = [[super alloc] init];
        }
        return instance;
    };
    return nil;
}


@end

