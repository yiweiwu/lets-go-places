//
//  Place.h
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/24/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Place : NSObject

@property(nonatomic, strong) NSString *placeDescription;
@property(nonatomic, strong) NSString *placeId;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) CLLocation *location;

- (NSString *)mapUrlWithSize:(CGSize)size;

@end