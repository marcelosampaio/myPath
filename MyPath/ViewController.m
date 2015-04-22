//
//  ViewController.m
//  MyPath
//
//  Created by Marcelo Sampaio on 4/21/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize timer,isOn,startStopButton;


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UI
    self.isOn=NO;
    [self.startStopButton setTitle: @"Start Collecting Locations" forState: UIControlStateNormal];
    
    
    
}


#pragma mark - UI Actions
- (IBAction)startStopAction:(id)sender {

}



@end
