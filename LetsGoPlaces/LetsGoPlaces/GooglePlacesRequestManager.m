//
//  GooglePlacesRequestManager.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/24/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "GooglePlacesRequestManager.h"

#import "AFNetworking.h"
#import "PlacesSerializer.h"

@interface GooglePlacesRequestManager ()

@property(nonatomic, strong) NSOperationQueue *requestQueue;

@end


static NSString *const GPAPIKey = @"AIzaSyDHXr1kT955ZT6lTBX2jbKWOe-o0OuocwI";
static NSString *const GPAutoCompleteURL = @"https://maps.googleapis.com/maps/api/place/autocomplete/json";


@implementation GooglePlacesRequestManager

+ (instancetype)sharedRequestManager
{
    static GooglePlacesRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.requestQueue = [[NSOperationQueue alloc] init];
        manager.requestQueue.maxConcurrentOperationCount = 5;
    });
    return manager;
}


- (void)autoCompletePlacesWithInput:(NSString *)input
                            success:(GPRequestSuccessBlock)success
                            failure:(GPRequestFailureBlock)failure
{
    // If the location is known, we can pass the location to the API
    NSDictionary *params = @{
                             @"input": input,
                             @"key": GPAPIKey,
                             @"radius": @(500),
                             @"types": @"geocode",
                             };
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                  URLString:GPAutoCompleteURL
                                                 parameters:params
                                                      error:nil];

    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    //TODO: User places serializer
    operation.responseSerializer = [PlacesSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Places %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    [self.requestQueue addOperation:operation];
}

@end
