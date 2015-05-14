//
//  ViewController.h
//  MyPath
//
//  Created by Marcelo Sampaio on 4/21/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Database.h"


@interface ViewController : UIViewController<CLLocationManagerDelegate>
/*! Outlet to start or stop main engine */
@property (strong, nonatomic) IBOutlet UIButton *startStopButton;
/*! Outlet to show all stored locations */
@property (strong, nonatomic) IBOutlet UIButton *locationsOutlet;
/*! Outlet to show map animations with stored data */
@property (strong, nonatomic) IBOutlet UIButton *animationOutlet;


/*! Returns a Boolean value that indicates that engine status is running. */
@property BOOL isOn;

/*! Database Object */
@property (nonatomic,strong) Database *database;

@end

