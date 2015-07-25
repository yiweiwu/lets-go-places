//
//  GooglePlacesResponseSerializer.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/24/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "GooglePlacesResponseSerializer.h"

NSString *const GooglePlacesSerializerErrorDomain = @"GooglePlacesSerializerError";

@implementation GooglePlacesResponseSerializer

- (id)responseObjectForResponse:(NSHTTPURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    NSDictionary *responseDict = [super responseObjectForResponse:response
                                                             data:data
                                                            error:error];
    
    if (responseDict && responseDict[@"status"] && [responseDict[@"status"] isEqualToString:@"OK"]) {
        return [self successParsedObjectForResponse:response responseDictionary:responseDict error:error];
    }
    else {
        // parsing error
        *error = [self errorForResponse:response responseDictionary:responseDict error:error];
        return nil;
    }
}


#pragma mark - 

- (id)successParsedObjectForResponse:(NSHTTPURLResponse *)response
                  responseDictionary:(NSDictionary *)responseDict
                               error:(NSError *__autoreleasing *)error
{
    return responseDict;
}

- (NSError *)errorForResponse:(NSHTTPURLResponse *)response
    responseDictionary:(NSDictionary *)responseDict
                 error:(NSError *__autoreleasing *)error
{
    NSString *errorMessage = responseDict[@"error_message"];
    NSString *status = responseDict[@"status"];
    
    // There is no error message when it's a zero results error
    NSDictionary *userInfo = nil;
    if (errorMessage) {
        userInfo = @{ NSLocalizedDescriptionKey: errorMessage };
    }
    
   return [NSError errorWithDomain:GooglePlacesSerializerErrorDomain
                              code:[self errorCodeFromResponse:response status:status]
                          userInfo:userInfo];
}

- (NSInteger)errorCodeFromResponse:(NSHTTPURLResponse *)response status:(NSString *)status
{
    return response.statusCode;
}

@end
