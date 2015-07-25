//
//  PlacesTableViewController.h
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/23/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Place;

@interface PlacesTableViewController : UITableViewController

@property(nonatomic, strong) NSArray *places;

- (Place *)placeAtIndexPath:(NSIndexPath *)indexPath;

@end
