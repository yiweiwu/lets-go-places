//
//  PlaceDetailsViewController.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/25/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "PlaceDetailsViewController.h"

#import "UIImageView+AFNetworking.h"
#import "GooglePlacesRequestManager.h"
#import "Place.h"

@interface PlaceDetailsViewController ()

@property(nonatomic, strong) UILabel *placeDescriptionLabel;
@property(nonatomic, strong) UIImageView *placeImageView;

@property(nonatomic, strong) NSOperation *placeDetailsOperation;

@end

@implementation PlaceDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Map";
    
    [self.view addSubview:self.placeDescriptionLabel];
    [self.view addSubview:self.placeImageView];
    
    //Constraints
    NSDictionary *viewDictionary = @{
                                     @"placeDescriptionLabel": self.placeDescriptionLabel,
                                     @"placeImageView": self.placeImageView,
                                     };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[placeDescriptionLabel(placeImageView)]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[placeImageView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[placeDescriptionLabel]-[placeImageView]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDictionary]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getPlaceDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (UILabel *)placeDescriptionLabel
{
    if (!_placeDescriptionLabel) {
        _placeDescriptionLabel = [[UILabel alloc] init];
        _placeDescriptionLabel.text = @"Place";
        _placeDescriptionLabel.font = [UIFont systemFontOfSize:20.0];
        _placeDescriptionLabel.backgroundColor = [UIColor whiteColor];
        _placeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _placeDescriptionLabel;
}

- (UIImageView *)placeImageView
{
    if (!_placeImageView) {
        _placeImageView = [[UIImageView alloc] init];
        _placeImageView.contentMode = UIViewContentModeScaleAspectFit;
        _placeImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _placeImageView;
}

#pragma mark - Request

- (void)getPlaceDetails
{
    if (self.placeDetailsOperation) {
        [self.placeDetailsOperation cancel];
        self.placeDetailsOperation = nil;
    }
    
    __weak PlaceDetailsViewController *weakSelf = self;
    self.placeDetailsOperation = [[GooglePlacesRequestManager sharedRequestManager]
                                  placeDetailWithPlaceId:self.place.placeId
                                  success:^(id responseObject) {
                                      if (weakSelf) {
                                          PlaceDetailsViewController *strongSelf = weakSelf;
                                          Place *place = (Place *)responseObject;
                                          [strongSelf populatePlace:place];
                                      }
                                  }
                                  failure:^(NSError *error) {
                                      UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Let's go places"
                                                                                                     message:error.localizedDescription
                                                                                              preferredStyle:UIAlertControllerStyleAlert];
                                      
                                      UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                                                   style:UIAlertActionStyleDefault
                                                                                 handler:^(UIAlertAction * action) {
                                                                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                                                                 }];
                                      
                                      [alert addAction:ok];
                                      
                                      [self presentViewController:alert animated:YES completion:nil];
                                  }];
    
    [[GooglePlacesRequestManager sharedRequestManager].requestQueue addOperation:self.placeDetailsOperation];
}

#pragma mark - UI

- (void)populatePlace:(Place *)place
{
    self.placeDescriptionLabel.text = place.name;
    NSURL *URL = [NSURL URLWithString:[place mapUrlWithSize:CGSizeMake(self.placeImageView.frame.size.width, self.placeImageView.frame.size.width)]];
    if (URL) {
        [self.placeImageView setImageWithURL:URL];
    }

    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}


@end
