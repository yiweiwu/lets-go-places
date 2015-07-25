//
//  PlaceDetailsSerializer.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/24/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "PlaceDetailsSerializer.h"

#import "Place.h"

typedef NS_ENUM(NSInteger, PlaceDetailsErrorCode) {
    PlaceDetailsErrorCodeUnknown = 1, // indicates a server-side error; trying again may be successful.
    PlaceDetailsErrorCodeZeroResults,  // indicates that the reference was valid but no longer refers to a valid result. This may occur if the establishment is no longer in business.
    PlaceDetailsErrorCodeOverQueryLimit,  // indicates that you are over your quota.
    PlaceDetailsErrorCodeRequestDenied,   // indicates that your request was denied, generally because of lack of an invalid key parameter.
    PlaceDetailsErrorCodeInvalidRequest, // generally indicates that the query (reference) is missing.
    PlaceDetailsErrorCodeNotFound,  // indicates that the referenced location was not found in the Places database.
};

@implementation PlaceDetailsSerializer

- (id)successParsedObjectForResponse:(NSHTTPURLResponse *)response
                  responseDictionary:(NSDictionary *)responseDict
                               error:(NSError *__autoreleasing *)error
{
    NSDictionary *result = responseDict[@"result"];
    
    Place *place = [[Place alloc] init];
    place.placeDescription = result[@"formatted_address"];
    place.placeId = result[@"place_id"];
    place.name = result[@"name"];
    
    NSDictionary *location = result[@"geometry"][@"location"];
    NSNumber *lat = location[@"lat"];
    NSNumber *lng = location[@"lng"];
    place.location = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lng doubleValue]];
    return place;
}

- (NSInteger)errorCodeFromResponse:(NSHTTPURLResponse *)response status:(NSString *)status
{
    NSInteger code = PlaceDetailsErrorCodeUnknown;
    if ([status isEqualToString:@"ZERO_RESULTS"]) {
        code = PlaceDetailsErrorCodeZeroResults;
    }
    else if ([status isEqualToString:@"OVER_QUERY_LIMIT"]) {
        code = PlaceDetailsErrorCodeOverQueryLimit;
    }
    else if ([status isEqualToString:@"REQUEST_DENIED"]) {
        code = PlaceDetailsErrorCodeRequestDenied;
    }
    else if ([status isEqualToString:@"INVALID_REQUEST"]) {
        code = PlaceDetailsErrorCodeInvalidRequest;
    }
    else if ([status isEqualToString:@"NOT_FOUND"]) {
        code = PlaceDetailsErrorCodeNotFound;
    }
    return code;
}

@end
