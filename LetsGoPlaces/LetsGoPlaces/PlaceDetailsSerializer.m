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
    //TODO: parse the response to into place objects
    return responseDict;
}

- (NSInteger)errorCodeFromResponse:(NSHTTPURLResponse *)response status:(NSString *)status
{
    return response.statusCode;
}

@end
