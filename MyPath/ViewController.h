//
//  ViewController.h
//  MyPath
//
//  Created by Marcelo Sampaio on 4/21/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController<CLLocationManagerDelegate>
/*! Outlet to start or stop main engine */
@property (strong, nonatomic) IBOutlet UIButton *startStopButton;


/*! Returns a Boolean value that indicates that engine status is running. */
@property BOOL isOn;

@end

