//
//  MapViewController.m
//  MyPath
//
//  Created by Marcelo Sampaio on 5/4/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "MapViewController.h"
#import "AppConfig.h"
#import "MapAnnotation.h"


@interface MapViewController ()

@end

@implementation MapViewController
@synthesize location,map;

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // plot location on map
    [self plotLocation];
    
}

#pragma mark - UI Actions
- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - Location
-(void)plotLocation{
    // Plotar estas coordenadas no mapView
    // Create a Region
    MKCoordinateRegion regiao;
    //Center
    CLLocationCoordinate2D center;
    center.latitude=self.location.latitude;
    center.longitude=self.location.longitude;
    
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
    [self addMapAnnotation];

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

-(void)addMapAnnotation{
    
    MapAnnotation *mapAnnotation=[[MapAnnotation alloc]init];
    NSMutableArray *annotations=[[NSMutableArray alloc]init];
    
    CLLocationCoordinate2D annotationCoordinate;
    annotationCoordinate.latitude=self.location.latitude;
    annotationCoordinate.longitude=self.location.longitude;
    //
    mapAnnotation.coordinate=annotationCoordinate;
    mapAnnotation.title=[NSString stringWithFormat:@"%@ %@ %@",self.location.thoroughfare,self.location.postalCode,self.location.administrativeArea];
    mapAnnotation.subtitle=self.location.eventDate;
//    mapAnnotation.reference=@"Reference";
    
    // load annotations
    [annotations addObject:mapAnnotation];
    
    // add annotation to the map
    [self.map addAnnotations:annotations];
    
    // Focus on map
    
    CLLocationCoordinate2D loc = {self.location.latitude,self.location.longitude};
    
    [self.map setRegion:MKCoordinateRegionMakeWithDistance(loc, DEFAULT_MAPKIT_DISTANCE_FROM_CENTER, DEFAULT_MAPKIT_DISTANCE_FROM_CENTER) animated:YES];
    
    // Open up Annotation View
    [self.map selectAnnotation:mapAnnotation animated:YES];
    
    NSLog(@"end add map annotation");
    
}
//
//-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
//    NSLog(@"didAddAnnotationViews");
//}

@end
