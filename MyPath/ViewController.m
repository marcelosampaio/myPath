//
//  ViewController.m
//  MyPath
//
//  Created by Marcelo Sampaio on 4/21/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseRow.h"
#import "AppConfig.h"

@interface ViewController ()

@end

@implementation ViewController {
    CLLocationManager *LocationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}


@synthesize isOn,startStopButton;
@synthesize database;
@synthesize locationsOutlet;


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    // hide navigation bar
    [self.navigationController.navigationBar setHidden:YES];
    
    // database initial procedures
    [self databaseInitialProcedures];
    
    // Check device screen size and configure UI
    [self configureUI];
    
    // Debug functionality
    [self debug];
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    
    
    
}

#pragma mark - UI Helper
-(void)configureUI{
    
    // UI
    self.isOn=NO;
    
    // start/stop button
    [self.startStopButton setTitle:DEFAULT_STRING_START_ACTION forState: UIControlStateNormal];
    self.startStopButton.layer.cornerRadius=100;
    self.startStopButton.layer.masksToBounds=YES;
    self.startStopButton.backgroundColor=DEFAULT_COLOR_GREEN;
    
    // locations button
    [self.locationsOutlet setTitle:DEFAULT_STRING_SHOW_LOCATIONS_ACTION forState: UIControlStateNormal];
    self.locationsOutlet.layer.cornerRadius=50;
    self.locationsOutlet.layer.masksToBounds=YES;
    self.locationsOutlet.backgroundColor=DEFAULT_COLOR_LOCATIONS_OUTLET;


    // main view
    self.view.backgroundColor=DEFAULT_COLOR_GREEN_ALPHA;

    
    
    if (self.view.frame.size.height<=480) {
        // This is a 3.5" screen size

        [UIView animateWithDuration:0.8 animations:^{
            // Animations
            self.startStopButton.center=CGPointMake(self.startStopButton.center.x, 0);
        } completion:^(BOOL finished) {
            // Completion
        }];
    }
}

#pragma mark - UI Actions
- (IBAction)startStopAction:(id)sender {
    if (self.isOn) {
        [self.startStopButton setTitle:DEFAULT_STRING_START_ACTION forState: UIControlStateNormal];
        self.startStopButton.backgroundColor=DEFAULT_COLOR_GREEN;
        self.view.backgroundColor=DEFAULT_COLOR_GREEN_ALPHA;
        self.isOn=NO;
        // stop core location
        [LocationManager stopUpdatingLocation];
        // enable locations outlet
        self.locationsOutlet.hidden=NO;
    }else{
        [self.startStopButton setTitle:DEFAULT_STRING_STOP_ACTION forState: UIControlStateNormal];
        self.startStopButton.backgroundColor=DEFAULT_COLOR_RED;
        self.view.backgroundColor=DEFAULT_COLOR_RED_ALPHA;
        self.isOn=YES;
        // start Location Manager
        [self startLocationManager];
        // disable locations outlet
        self.locationsOutlet.hidden=YES;
    }
}

#pragma mark - Location Manager Brain
-(void)startLocationManager {
    LocationManager=[[CLLocationManager alloc]init];
    geocoder=[[CLGeocoder alloc]init];
    
    LocationManager.delegate=self;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([LocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [LocationManager requestWhenInUseAuthorization];
    }
    //    if ([LocationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
    //        [LocationManager requestAlwaysAuthorization];
    //    }
    
    
    LocationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [LocationManager startUpdatingLocation];
}



#pragma mark - Location Manager Delegate
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"location manager error=%@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    CLLocation *location=[manager location];    
    
    // Geocoder
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error==nil && placemarks.count>0) {

            placemark=placemarks.lastObject;

            // insert row into location's database
            [self.database insertLocation:[[DatabaseRow alloc]initWithEventType:0 latitude:location.coordinate.latitude longitude:location.coordinate.longitude thoroughfare:placemark.thoroughfare postalCode:placemark.postalCode locality:@"" administrativeArea:placemark.administrativeArea country:placemark.country eventDate:nil]];
            
            
        }else {
            NSLog(@"Geocoder Error: %@",error.debugDescription);
        }
        
    }];
    
}


#pragma mark - DataBase Methods
-(void)databaseInitialProcedures {
    
    self.database=[[Database alloc]init];
    
    // copy database from resource folder to documents folder
    [self.database copyDatabaseToWritableFolder];
    
}

#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden{
    return YES;
}


#pragma mark - Debug Facility
-(void)debug{
    NSMutableArray *locations=[self.database getLocations];
    NSLog(@"locations count=%lu",(unsigned long)locations.count);
    
    for (DatabaseRow *location in locations) {
        NSLog(@"----------------------------------");
//        NSLog(@"eventType=%d",location.eventType);
        NSLog(@"thoroughfare=%@",location.thoroughfare);
        NSLog(@"postalCode=%@",location.postalCode);
//        NSLog(@"latitude=%f",location.latitude);
//        NSLog(@"longitude=%f",location.longitude);
        NSLog(@"eventDate=%@",location.eventDate);
        NSLog(@"----------------------------------");
    }
//    [self.database removeLocations];
    
}

@end
