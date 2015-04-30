//
//  ViewController.m
//  MyPath
//
//  Created by Marcelo Sampaio on 4/21/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseRow.h"

#define DEFAULT_STRING_START_ACTION             @"S T A R T"
#define DEFAULT_STRING_STOP_ACTION              @"S T O P"
#define DEFAULT_COLOR_GREEN                     [UIColor colorWithRed:0.1 green:0.75f blue:0.1 alpha:1];
#define DEFAULT_COLOR_GREEN_ALPHA               [UIColor colorWithRed:0.1 green:0.75f blue:0.1 alpha:0.25];
#define DEFAULT_COLOR_RED                       [UIColor colorWithRed:1.0 green:0.15f blue:0.15 alpha:1];
#define DEFAULT_COLOR_RED_ALPHA                 [UIColor colorWithRed:1.0 green:0.15f blue:0.15 alpha:0.25];

@interface ViewController ()

@end

@implementation ViewController {
    CLLocationManager *LocationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}


@synthesize isOn,startStopButton;
@synthesize database;


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // database initial procedures
    [self databaseInitialProcedures];

    // UI
    self.isOn=NO;
    [self.startStopButton setTitle:DEFAULT_STRING_START_ACTION forState: UIControlStateNormal];
    self.startStopButton.layer.cornerRadius=100;
    self.startStopButton.layer.masksToBounds=YES;
    self.startStopButton.backgroundColor=DEFAULT_COLOR_GREEN;
    self.view.backgroundColor=DEFAULT_COLOR_GREEN_ALPHA;
    
    // Check device screen size and configure UI
    [self configureUI];
    
    
}

#pragma mark - UI Helper
-(void)configureUI{
    
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
    }else{
        [self.startStopButton setTitle:DEFAULT_STRING_STOP_ACTION forState: UIControlStateNormal];
        self.startStopButton.backgroundColor=DEFAULT_COLOR_RED;
        self.view.backgroundColor=DEFAULT_COLOR_RED_ALPHA;
        self.isOn=YES;
        // start Location Manager
        [self startLocationManager];
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
            
//            NSString *address=[NSString stringWithFormat:@"%@ %@ %@ %@ %@",placemark.thoroughfare,placemark.postalCode,placemark.locality,placemark.administrativeArea,placemark.country];
            //            NSLog(@"%@ %@\n%@ %@\n%@\n%@",placemark.subThoroughfare,placemark.thoroughfare,placemark.postalCode,placemark.locality,placemark.administrativeArea,placemark.country);
            
            
            NSLog(@"              --> longitude=%f",location.coordinate.longitude);
            
            // format database row object
            DatabaseRow *databaseRow=[[DatabaseRow alloc]initWithEventType:0 latitude:location.coordinate.latitude longitude:location.coordinate.longitude thoroughfare:placemark.thoroughfare postalCode:placemark.postalCode locality:@"" administrativeArea:placemark.administrativeArea country:placemark.country eventDate:nil];
            
            // insert row into location's database
            [self.database insertLocation:databaseRow];
            
            
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

@end
