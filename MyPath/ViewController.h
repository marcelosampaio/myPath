//
//  ViewController.h
//  MyPath
//
//  Created by Marcelo Sampaio on 4/21/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
/*! Outlet to start or stop main engine */
@property (strong, nonatomic) IBOutlet UIButton *startStopButton;




/*! Timer responsible to keep alive main pulse */
@property (nonatomic,strong) NSTimer *timer;

/*! Boolean flag to indicate engine is on */
@property BOOL isOn;

@end

