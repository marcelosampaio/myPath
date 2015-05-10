//
//  LocationsViewController.m
//  MyPath
//
//  Created by Marcelo Sampaio on 5/3/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "LocationsViewController.h"
#import "AppConfig.h"
#import "Database.h"
#import "DatabaseRow.h"
#import "MapViewController.h"

@interface LocationsViewController ()

@end

@implementation LocationsViewController
@synthesize closeOutlet,tableView;
@synthesize locations;


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    // Get locations
    [self loadSource];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    // set background color
    self.view.backgroundColor=DEFAULT_COLOR_LOCATIONS_OUTLET;
    
    // set table view backgorund color
    self.tableView.backgroundColor=DEFAULT_COLOR_LOCATIONS_OUTLET;
    
}

#pragma mark - Working Methods
-(void)loadSource {
    
    self.locations=[[NSMutableArray alloc]init];
    
    Database *database=[[Database alloc]init];
    self.locations=[database getLocations];
    
    [self.tableView reloadData];
    
}

#pragma mark - UI Actions

- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - TableView DataSource and Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locations.count;
}


-(UITableViewCell *)tableView:(UITableView *)a_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell = [a_tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    DatabaseRow *row=[self.locations objectAtIndex:indexPath.row];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@ %@ %@",row.thoroughfare,row.postalCode,row.administrativeArea];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@     (%f,%f)",row.eventDate,row.latitude,row.longitude];
    
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    
    cell.backgroundColor=DEFAULT_COLOR_LOCATIONS_OUTLET;
    
    
    return cell;
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMap"]) {
        
        // get indexPath of selected row
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        
        // Passing database row object to map view controller
        MapViewController *mapViewController= (MapViewController *)segue.destinationViewController;
        mapViewController.location=[self.locations objectAtIndex:indexPath.row];
        
    }
}

@end
