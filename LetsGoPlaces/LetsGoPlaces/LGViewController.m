//
//  LGViewController.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/26/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "LGViewController.h"

@interface LGViewController ()

@end

@implementation LGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Common settings in viewDidLoad
    self.view.backgroundColor = [UIColor whiteColor];
    
    // All the subviews should be placed below nav bar
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
