//
//  MapViewController.m
//  MyPath
//
//  Created by Marcelo Sampaio on 5/4/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set map delegate
    self.map.delegate=self;
}


#pragma mark - UI Actions
- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
