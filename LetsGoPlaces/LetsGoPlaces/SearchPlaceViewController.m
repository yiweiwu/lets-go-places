//
//  ViewController.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/23/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "SearchPlaceViewController.h"

#import "GooglePlacesRequestManager.h"
#import "PlacesTableViewController.h"
#import "UIViewController+Error.h"

@interface SearchPlaceViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) PlacesTableViewController *placesTableViewController;

@end

static NSString *const placeTableViewCellIdentifier = @"PlaceTableViewCellId";

@implementation SearchPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Let's go places";
    
    // Show the search bar
    [self.searchController.searchBar sizeToFit];
    [self.view addSubview:self.searchController.searchBar];
    
    self.definesPresentationContext = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (PlacesTableViewController *)placesTableViewController
{
    if (!_placesTableViewController) {
        _placesTableViewController = [[PlacesTableViewController alloc] init];
    }
    return _placesTableViewController;
}

- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.placesTableViewController];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
        _searchController.searchBar.delegate = self;
    }
    return _searchController;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchTerm = searchController.searchBar.text;
    
    // Only search when the user enters equal or more than 3 characters
    if ([searchTerm length] < 3) {
        return;
    }
    
    // make Google Places API request
    __weak id weakSelf = self;
    NSOperation *operation = [[GooglePlacesRequestManager sharedRequestManager]
        autoCompletePlacesWithInput:searchTerm
        success:^(id places) {
            if (weakSelf) {
                // Populate the results
                SearchPlaceViewController *strongSelf = weakSelf;
                PlacesTableViewController *placesTableViewController = strongSelf.placesTableViewController;
                placesTableViewController.places = places;
                [placesTableViewController.tableView reloadData];
            }
        }
        failure:^(NSError *error) {
            if (weakSelf) {
                SearchPlaceViewController *strongSelf = weakSelf;
                
                // Inform the user about the error
                [strongSelf showAlertControllerWithError:error];
                
                // Clear the previous results
                PlacesTableViewController *placesTableViewController = strongSelf.placesTableViewController;
                placesTableViewController.places = @[];
                [placesTableViewController.tableView reloadData];
            }
        }];
    [[GooglePlacesRequestManager sharedRequestManager].requestQueue addOperation:operation];
}

@end
