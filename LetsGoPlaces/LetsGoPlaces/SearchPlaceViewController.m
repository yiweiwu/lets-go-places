//
//  ViewController.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/23/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "SearchPlaceViewController.h"

@interface SearchPlaceViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;

@end

NSString *const placeTableViewCellIdentifier = @"PlaceTableViewCellId";

@implementation SearchPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Let's go places";
    self.view.backgroundColor = [UIColor blueColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:placeTableViewCellIdentifier];
    
    // Show the search bar
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
        _searchController.searchBar.delegate = self;
    }
    return _searchController;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:placeTableViewCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // make Google Places API request
}

@end
