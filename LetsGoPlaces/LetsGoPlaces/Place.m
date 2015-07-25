//
//  Place.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/24/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "Place.h"

@implementation Place

- (NSString *)mapUrlWithSize:(CGSize)size
{
    NSString *staticMapAPI = @"https://maps.googleapis.com/maps/api/staticmap?";
    
    NSString *center = [NSString stringWithFormat:@"%f,%f", self.location.coordinate.latitude, self.location.coordinate.longitude];
    NSString *sizeString = [NSString stringWithFormat:@"%ldx%ld", (NSInteger)size.width, (NSInteger)size.height];
    
    NSMutableString *url = [NSMutableString stringWithString:staticMapAPI];
    [url appendFormat:@"center=%@&zoom=12&size=%@", center, sizeString];
    
    return url;
}

@end
