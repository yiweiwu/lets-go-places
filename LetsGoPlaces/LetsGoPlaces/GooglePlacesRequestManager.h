//
//  GooglePlacesRequestManager.h
//  LetsGoPlaces
//
//  Created by Yi-Wei on 7/24/15.
//  Copyright (c) 2015 Yi-Wei Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GPRequestSuccessBlock) (id );
typedef void (^GPRequestFailureBlock) (NSError *);


/*! 
 * A singleton manager to make request to google places API
 * 
 * @discussion Usually, I wrap the AFHTTPRequestOperation.
 * However, it will take more time to do it
 * and a manager should be good enough for now.
 */
@interface GooglePlacesRequestManager : NSObject

/// Return a shared GooglePlacesRequestManager
+ (instancetype)sharedRequestManager;

/// Make auto complete API request with input
- (void)autoCompletePlacesWithInput:(NSString *)input
                            success:(GPRequestSuccessBlock)success
                            failure:(GPRequestFailureBlock)failure;

/// Make place details API request with place id
- (void)placeDetailWithPlaceId:(NSString *)placeId
                       success:(GPRequestSuccessBlock)success
                       failure:(GPRequestFailureBlock)failure;

@end
