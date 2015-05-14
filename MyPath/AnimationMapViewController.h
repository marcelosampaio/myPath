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

/*! Property containg all DatabaseRow objects (Locations) */
@property (nonatomic,strong) NSMutableArray *locations;


@end
