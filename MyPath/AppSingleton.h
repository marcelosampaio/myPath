//
//  AppSingleton.h
//  MyPath
//
//  Created by Marcelo Sampaio on 5/28/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSingleton : NSObject

@property (nonatomic,strong) NSString *timelineControl;


+ (AppSingleton *) instance;

@end
