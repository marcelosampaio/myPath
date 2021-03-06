//
//  LocationsViewController.h
//  MyPath
//
//  Created by Marcelo Sampaio on 5/3/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *closeOutlet;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


/*! Array with locations (DatabaseRow)*/
@property (nonatomic, strong) NSMutableArray *locations;



@end
