//
//  PlacesSerializer.m
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/24/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import "PlacesSerializer.h"

#import "Place.h"

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
        
        
        return nil;
    }
}

@end
