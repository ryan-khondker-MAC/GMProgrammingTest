//
//  NetworkService.h
//  WeatherAppTest
//
//  Created by Ryan on 4/13/18.
//  Copyright © 2018 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject

+ (void) getWeatherForCity:(NSString * _Nonnull) city inState:(NSString * _Nonnull) state completion:(void (^ _Nullable)(NSError * _Nullable, NSArray * _Nullable)) callback;

@end
