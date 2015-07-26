//
//  UIViewController+Error.h
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/26/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *  The category for the common way of error handling on UIViewController.
 *  Here we're gonna display an alert to inform the user.
 */
@interface UIViewController (Error)

- (void)showAlertControllerWithError:(NSError *)error;

@end
