//
//  GooglePlacesRequestManager.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/24/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "GooglePlacesRequestManager.h"

#import "AFNetworking.h"
#import "PlaceAutoCompleteSerializer.h"
#import "PlaceDetailsSerializer.h"

@interface GooglePlacesRequestManager ()

@end


static NSString *const GPAPIKey = @"AIzaSyDHXr1kT955ZT6lTBX2jbKWOe-o0OuocwI";
static NSString *const GPAutoCompleteURL = @"https://maps.googleapis.com/maps/api/place/autocomplete/json";
static NSString *const GPPlaceDetailsURL = @"https://maps.googleapis.com/maps/api/place/details/json";


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


- (NSOperation *)autoCompletePlacesWithInput:(NSString *)input
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
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                        requestWithMethod:@"GET"
                                                URLString:GPAutoCompleteURL
                                               parameters:params
                                                    error:nil];

    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [PlaceAutoCompleteSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return operation;
}

- (NSOperation *)placeDetailWithPlaceId:(NSString *)placeId
                                success:(GPRequestSuccessBlock)success
                                failure:(GPRequestFailureBlock)failure
{
    // If the location is known, we can pass the location to the API
    NSDictionary *params = @{
                             @"placeid": placeId,
                             @"key": GPAPIKey,
                             };
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                        requestWithMethod:@"GET"
                                                URLString:GPPlaceDetailsURL
                                               parameters:params
                                                    error:nil];
    
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [PlaceDetailsSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    return operation;
}

@end
