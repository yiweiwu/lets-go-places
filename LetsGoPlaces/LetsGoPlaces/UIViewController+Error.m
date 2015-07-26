//
//  UIViewController+Error.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/26/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "UIViewController+Error.h"

static NSString *const LGAlertTitle = @"Let's go places";

@implementation UIViewController (Error)

- (void)showAlertControllerWithError:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:LGAlertTitle
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                               }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
