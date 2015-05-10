//
//  MapAnnotation.h
//  MyPath
//
//  Created by Marcelo Sampaio on 5/10/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MapAnnotation : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic,copy) NSString *subtitle;
@property(nonatomic,strong) NSString *reference;


@end
