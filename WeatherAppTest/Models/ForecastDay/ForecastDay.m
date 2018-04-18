//
//  ForecastDay.m
//  WeatherAppTest
//
//  Created by Ryan on 4/13/18.
//  Copyright © 2018 Ryan. All rights reserved.
//

#import "ForecastDay.h"

@implementation ForecastDay

@synthesize month, day, year, high, low, conditions;

- (ForecastDay *) initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    self.month = [[dictionary objectForKey:@"date"] objectForKey:@"month"];
    self.day = [[dictionary objectForKey:@"date"] objectForKey:@"day"];
    self.year = [[dictionary objectForKey:@"date"] objectForKey:@"year"];
    self.high = [[dictionary objectForKey:@"high"] objectForKey:@"fahrenheit"];
    self.low = [[dictionary objectForKey:@"low"] objectForKey:@"fahrenheit"];
    self.conditions = [dictionary objectForKey:@"conditions"];
    return self;
}

@end
