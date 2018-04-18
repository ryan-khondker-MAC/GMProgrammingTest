//
//  NetworkService.m
//  WeatherAppTest
//
//  Created by Ryan on 4/13/18.
//  Copyright © 2018 Ryan. All rights reserved.
//

#import "NetworkService.h"
#import "ForecastDay.h"

@interface NetworkService()

+ (NSString *) apiBaseUrl;

@end

@implementation NetworkService

typedef enum {invalidUrl, noResponse, badResponse, noData} NetworkErrors;

+ (NSString *) apiBaseUrl {
    return @"https://api.wunderground.com/api/b058bb83eb8b1cef/forecast/geolookup/conditions/q/";
}

+ (void) getWeatherForCity:(NSString *) city inState:(NSString *) state completion:(void (^)(NSError * _Nullable, NSArray * _Nullable)) callback {
    NSString * urlAsString = [NSString stringWithFormat:@"%@%@/%@.json", [self apiBaseUrl], state, [city stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
    NSURL * _Nullable url = [[NSURL alloc] initWithString: urlAsString];
    
    if (url == Nil) {
        NSError * invalidUrlError = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:invalidUrl userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"URL %@ is invalid", urlAsString]}];
        callback(invalidUrlError, Nil);
        return;
    }
    
    NSURLSession * session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != Nil) {
            NSLog(@"%@", error);
            callback(error, Nil);
            return;
        }
        
        if (response == Nil) {
            NSError * noResponseError = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:noResponse userInfo:@{NSLocalizedDescriptionKey: @"No response"}];
            callback(noResponseError, nil);
            return;
        }
        else {
            if ([response isKindOfClass:NSHTTPURLResponse.class]) {
                NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
                long responseCode = httpResponse.statusCode;
                if (httpResponse.statusCode != 200) {
                    NSError * httpError = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:badResponse userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"%ld Error", responseCode]}];
                    callback(httpError, nil);
                    return;
                }
            }
        }
        
        if (data != Nil) {
            NSError * _Nullable error = nil;
            id objects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            if ([objects isKindOfClass:[NSDictionary class]]) {
                if ([[objects objectForKey:@"response"] objectForKey:@"error"] != Nil) {
                    NSError * noDataError = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:noData userInfo:@{NSLocalizedDescriptionKey: @"No data"}];
                    callback(noDataError, Nil);
                    return;
                }
                NSArray * forecastDays = [[[objects objectForKey:@"forecast"] objectForKey:@"simpleforecast"] objectForKey:@"forecastday"];
                if (forecastDays == Nil) {
                    NSError * noDataError = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:noData userInfo:@{NSLocalizedDescriptionKey: @"No data"}];
                    callback(noDataError, Nil);
                    return;
                }
                NSMutableArray * forecast = [NSMutableArray array];
                for (int i = 0; i <= 2; i++) {
                    if ([[forecastDays objectAtIndex:i] isKindOfClass:[NSDictionary class]]) {
                        ForecastDay *day = [[ForecastDay alloc] initWithDictionary: [forecastDays objectAtIndex:i]];
                        [forecast addObject:day];
                    }
                }
                callback(Nil, forecast);
                return;
            } else if (error != Nil) {
                callback(error, Nil);
                return;
            } else {
                callback(Nil, Nil);
                return;
            }
        }
        else {
            NSError * noDataError = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:noData userInfo:@{NSLocalizedDescriptionKey: @"No data"}];
            callback(noDataError, nil);
            return;
        }
    }] resume];
}

@end
