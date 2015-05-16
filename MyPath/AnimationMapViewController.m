//
//  AnimationMapViewController.m
//  MyPath
//
//  Created by Marcelo Sampaio on 5/14/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "AnimationMapViewController.h"
#import "Database.h"
#import "DatabaseRow.h"
#import "AppConfig.h"
#import "MapAnnotation.h"


@interface AnimationMapViewController ()
@property int locationCounter;
@end

@implementation AnimationMapViewController

@synthesize map;
@synthesize locations;
@synthesize animationOutlet;
@synthesize locationCounter;
@synthesize engineTimer;
@synthesize addressOutlet,dateOutlet;

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    // load all data
    Database *database=[[Database alloc]init];
    self.locations=[[NSMutableArray alloc]init];
    self.locations=[database getLocationsOrdered:YES];
    
    // Reset labels
    self.addressOutlet.text=@"";
    self.dateOutlet.text=@"";
    
    locationCounter=0;
    
    // Set up engine main timer
    self.engineTimer=[NSTimer scheduledTimerWithTimeInterval:0.30f target:self selector:@selector(pulse) userInfo:nil repeats:YES];
    // start up engine timer
    [self.engineTimer fire];
    

}


#pragma mark - Animation Engine
-(void)animationEngine{
    for (DatabaseRow *location in self.locations) {
        [self plotLocationWithObject:location];
        locationCounter++;
        NSLog(@"counter:%d lat=%f lon=%f",locationCounter,location.latitude,location.longitude);
        if (locationCounter>=102) {
            break;
        }
    }
}

-(void)plotLocationWithObject:(DatabaseRow *)location{
    
    // Plotar estas coordenadas no mapView
    // Create a Region
    MKCoordinateRegion regiao;
    //Center
    CLLocationCoordinate2D center;
    center.latitude=location.latitude;
    center.longitude=location.longitude;

    // Span
    MKCoordinateSpan defaultSpan;
    defaultSpan.latitudeDelta = DEFAULT_MAPKIT_MAXSPAN;
    defaultSpan.longitudeDelta = DEFAULT_MAPKIT_MAXSPAN;
    
    regiao.center=center;
    regiao.span=defaultSpan;
    
    [self.map setRegion:regiao animated:YES];
    
    // remove prevous annotations
    [self removeMapAnnotations];
    
    // add current location
    [self addMapAnnotationWithObject:location];
    
}

-(void)removeMapAnnotations{
    NSMutableArray *toRemove=[[NSMutableArray alloc]init];
    for (id annotation in self.map.annotations)
    {
        if (annotation != self.map.userLocation)
        {
            [toRemove addObject:annotation];
        }
    }
    [self.map removeAnnotations:toRemove];
}

-(void)addMapAnnotationWithObject:(DatabaseRow *)location{
    
    MapAnnotation *mapAnnotation=[[MapAnnotation alloc]init];
    NSMutableArray *annotations=[[NSMutableArray alloc]init];
    
    CLLocationCoordinate2D annotationCoordinate;
    annotationCoordinate.latitude=location.latitude;
    annotationCoordinate.longitude=location.longitude;
    //
    mapAnnotation.coordinate=annotationCoordinate;
    mapAnnotation.title=[NSString stringWithFormat:@"%@ %@ %@",location.thoroughfare,location.postalCode,location.administrativeArea];
    mapAnnotation.subtitle=location.eventDate;
    //    mapAnnotation.reference=@"Reference";
    
    // load annotations
    [annotations addObject:mapAnnotation];
    
    // add annotation to the map
    [self.map addAnnotations:annotations];

    // Load labels
    self.addressOutlet.text=[NSString stringWithFormat:@"%@ %@ %@",location.thoroughfare,location.postalCode,location.administrativeArea];
    self.dateOutlet.text=location.eventDate;
    
    // Focus on map
    CLLocationCoordinate2D loc = {location.latitude,location.longitude};
    [self.map setRegion:MKCoordinateRegionMakeWithDistance(loc, DEFAULT_MAPKIT_DISTANCE_FROM_CENTER, DEFAULT_MAPKIT_DISTANCE_FROM_CENTER) animated:YES];
    
//    // Open up Annotation View
//    [self.map selectAnnotation:mapAnnotation animated:YES];
    
    
}


#pragma mark - Timer Methods
-(void)pulse{
    
    if (locationCounter>self.locations.count) {
        [self.engineTimer invalidate];
        return;
    }
    
    
    DatabaseRow *location=[[DatabaseRow alloc]init];
    location=[self.locations objectAtIndex:locationCounter];
    [self plotLocationWithObject:location];
    
    NSLog(@"pulsing... %d",locationCounter);

    locationCounter++;
    
    
}

- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
