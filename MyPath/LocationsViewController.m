//
//  LocationsViewController.m
//  MyPath
//
//  Created by Marcelo Sampaio on 5/3/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "LocationsViewController.h"
#import "AppConfig.h"

@interface LocationsViewController ()

@end

@implementation LocationsViewController
@synthesize closeOutlet;


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    // set background color
    self.view.backgroundColor=DEFAULT_COLOR_LOCATIONS_OUTLET;
}



#pragma mark - UI Actions

- (IBAction)close:(id)sender {
    NSLog(@"close");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
