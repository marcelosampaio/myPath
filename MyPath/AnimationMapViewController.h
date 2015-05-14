//
//  AnimationMapViewController.h
//  MyPath
//
//  Created by Marcelo Sampaio on 5/14/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AnimationMapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet UIButton *animationOutlet;
@property (strong, nonatomic) IBOutlet UILabel *addressOutlet;
@property (strong, nonatomic) IBOutlet UILabel *dateOutlet;




/*! Property containg all DatabaseRow objects (Locations) */
@property (nonatomic,strong) NSMutableArray *locations;

/*! Timer to control the main pulse of the engine */
@property (nonatomic,strong) NSTimer *engineTimer;


@end
