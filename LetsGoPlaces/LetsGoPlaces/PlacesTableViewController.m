//
//  PlacesTableViewController.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/23/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "PlacesTableViewController.h"

#import "GooglePlacesRequestManager.h"
#import "Place.h"
#import "PlaceDetailsViewController.h"

@interface PlacesTableViewController ()

@end

static NSString *const placeTableViewCellIdentifier = @"PlaceTableViewCellId";

@implementation PlacesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up tableView
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:placeTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:placeTableViewCellIdentifier forIndexPath:indexPath];
    Place *place = [self placeAtIndexPath:indexPath];
    if (place) {
        cell.textLabel.text = place.placeDescription? place.placeDescription: @"";
    }
    else {
        cell.textLabel.text = @"";
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Place *place = [self placeAtIndexPath:indexPath];
    
    PlaceDetailsViewController *placeDetailsViewController = [[PlaceDetailsViewController alloc] init];
    placeDetailsViewController.place = place;
    [self.presentingViewController.navigationController pushViewController:placeDetailsViewController animated:YES];
}

#pragma mark - Place

- (Place *)placeAtIndexPath:(NSIndexPath *)indexPath
{
    // Avoid out of index exception
    if ([self.places count] > indexPath.row) {
        return self.places[indexPath.row];
    }
    return nil;
}

@end
