//
//  ForecastDay.h
//  WeatherAppTest
//
//  Created by Ryan on 4/13/18.
//  Copyright © 2018 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastDay : NSObject

@property (nonatomic) NSNumber *month;
@property (nonatomic) NSNumber *day;
@property (nonatomic) NSNumber *year;
@property (nonatomic) NSString *high;
@property (nonatomic) NSString *low;
@property (nonatomic) NSString *conditions;

-(ForecastDay *) initWithDictionary:(NSDictionary *) dictionary;

@end
