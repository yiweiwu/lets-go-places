//
//  GooglePlacesResponseSerializer.h
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/24/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "AFURLResponseSerialization.h"

@interface GooglePlacesResponseSerializer : AFJSONResponseSerializer


/// Return the parse the objects for success response
- (id)successParsedObjectForResponse:(NSHTTPURLResponse *)response
                  responseDictionary:(NSDictionary *)responseDict
                               error:(NSError *__autoreleasing *)error;

/// Return the error for failed response
- (NSError *)errorForResponse:(NSHTTPURLResponse *)response
           responseDictionary:(NSDictionary *)responseDict
                        error:(NSError *__autoreleasing *)error;

/// Return an erro code that will be used in the failed response's error
- (NSInteger)errorCodeFromResponse:(NSHTTPURLResponse *)response status:(NSString *)status;

@end
