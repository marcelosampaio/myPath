//
//  MapViewController.h
//  MyPath
//
//  Created by Marcelo Sampaio on 5/4/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DatabaseRow.h"


@interface MapViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *map;


@property (nonatomic, strong) DatabaseRow *location;

@end
