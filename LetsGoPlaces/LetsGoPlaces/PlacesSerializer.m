//
//  PlacesSerializer.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/24/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "PlacesSerializer.h"

#import "Place.h"

NSString *const PlaceSerializerErrorDomain = @"PlaceSerializerError";

typedef NS_ENUM(NSInteger, AutoCompleteErrorCode) {
    AutoCompleteErrorCodeZeroResults = 1,  //indicates that the search was successful but returned no results. This may occur if the search was passed a bounds in a remote location.
    AutoCompleteErrorCodeOverQueryLimit,  // indicates that you are over your quota.
    AutoCompleteErrorCodeRequestDenied,   // indicates that your request was denied, generally because of lack of an invalid key parameter.
    AutoCompleteErrorCodeInvalidRequest, // generally indicates that the input parameter is missing.
    
    AutoCompleteErrorCodeUnknown = -1, // Shouldn't get this. It's not documented on google.
};

@implementation PlacesSerializer

- (id)responseObjectForResponse:(NSHTTPURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    NSDictionary *responseDict = [super responseObjectForResponse:response
                                                 data:data
                                                error:error];
    
    if (responseDict && responseDict[@"status"] && [responseDict[@"status"] isEqualToString:@"OK"]) {
        
        NSArray *predictions = responseDict[@"predictions"];
        
        NSMutableArray *places = [NSMutableArray arrayWithCapacity:[predictions count]];
        for (NSDictionary *predicationDict in predictions) {
            Place *place = [[Place alloc] init];
            place.placeDescription = predicationDict[@"description"];
            place.placeId = predicationDict[@"place_id"];
            // setting more properties if needed...
            
            [places addObject:place];
        }
        
        return places;
    }
    else {
        // parsing error
        
        NSString *errorMessage = responseDict[@"error_message"];
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: errorMessage };
        
        // get error code by status
        NSString *status = responseDict[@"status"];
        NSInteger code = AutoCompleteErrorCodeUnknown;
        if ([status isEqualToString:@"ZERO_RESULTS"]) {
            code = AutoCompleteErrorCodeZeroResults;
        }
        else if ([status isEqualToString:@"OVER_QUERY_LIMIT"]){
            code = AutoCompleteErrorCodeOverQueryLimit;
        }
        else if ([status isEqualToString:@"REQUEST_DENIED"]){
            code = AutoCompleteErrorCodeRequestDenied;
        }
        else if ([status isEqualToString:@"INVALID_REQUEST"]){
            code = AutoCompleteErrorCodeInvalidRequest;
        }
        
        NSError *apiError = [NSError errorWithDomain:PlaceSerializerErrorDomain
                                                code:code
                                            userInfo:userInfo];
        
        *error = apiError;
        
        return nil;
    }
}

@end
