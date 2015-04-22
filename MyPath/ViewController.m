//
//  ViewController.m
//  MyPath
//
//  Created by Marcelo Sampaio on 4/21/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"

#define DEFAULT_STRING_START_ACTION             @"Start"
#define DEFAULT_STRING_STOP_ACTION             @"Stop"

@interface ViewController ()

@end

@implementation ViewController

@synthesize timer,isOn,startStopButton;


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UI
    self.isOn=NO;
    [self.startStopButton setTitle:DEFAULT_STRING_START_ACTION forState: UIControlStateNormal];
    self.startStopButton.layer.cornerRadius=50;
    self.startStopButton.layer.masksToBounds=YES;
    self.startStopButton.backgroundColor=[UIColor colorWithRed:0.2 green:0.75f blue:0.1 alpha:2];
    
    
    
}


#pragma mark - UI Actions
- (IBAction)startStopAction:(id)sender {
    if (self.isOn) {
        [self.startStopButton setTitle:DEFAULT_STRING_START_ACTION forState: UIControlStateNormal];
        self.startStopButton.backgroundColor=[UIColor colorWithRed:0.2 green:0.75f blue:0.1 alpha:2];
        self.isOn=NO;
    }else{
        [self.startStopButton setTitle:DEFAULT_STRING_STOP_ACTION forState: UIControlStateNormal];
        self.startStopButton.backgroundColor=[UIColor redColor];
        self.isOn=YES;
    }
}



@end
