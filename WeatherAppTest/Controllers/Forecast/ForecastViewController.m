//
//  ForecastViewController.m
//  WeatherAppTest
//
//  Created by Ryan on 4/13/18.
//  Copyright © 2018 Ryan. All rights reserved.
//

#import "ForecastViewController.h"
#import "NetworkService.h"
#import "ForecastDay.h"

@interface ForecastViewController ()

- (void) loadWeatherForecast;

@end

@implementation ForecastViewController

@synthesize weatherLabel, day1DateLabel, day1HighTempLabel, day1LowTempLabel, day1DescriptionLabel, day2DateLabel, day2HighTempLabel, day2LowTempLabel, day2DescriptionLabel, day3DateLabel, day3HighTempLabel, day3LowTempLabel, day3DescriptionLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadWeatherForecast];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadWeatherForecast {
    [NetworkService getWeatherForCity:_cityName inState:_stateName completion:^(NSError * _Nullable error, NSArray * _Nullable forecast) {
        if (error != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weatherLabel.textColor = UIColor.redColor;
                weatherLabel.text = error.localizedDescription;
            });
        }
        if (forecast != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[forecast objectAtIndex:0] isKindOfClass:[ForecastDay class]]) {
                    day1DateLabel.text = [NSString stringWithFormat:@"%@/%@/%@", [(ForecastDay *) [forecast objectAtIndex:0] month], [(ForecastDay *) [forecast objectAtIndex:0] day], [(ForecastDay *) [forecast objectAtIndex:0] year]];
                    day1HighTempLabel.text = [NSString stringWithFormat:@"High Temperature: %@°F", [(ForecastDay *) [forecast objectAtIndex:0] high]];
                    day1LowTempLabel.text = [NSString stringWithFormat:@"Low Temperature: %@°F", [(ForecastDay *) [forecast objectAtIndex:0] low]];
                    day1DescriptionLabel.text = [NSString stringWithFormat:@"%@", [(ForecastDay *) [forecast objectAtIndex:0] conditions]];
                }
                if ([[forecast objectAtIndex:1] isKindOfClass:[ForecastDay class]]) {
                    day2DateLabel.text = [NSString stringWithFormat:@"%@/%@/%@", [(ForecastDay *) [forecast objectAtIndex:1] month], [(ForecastDay *) [forecast objectAtIndex:1] day], [(ForecastDay *) [forecast objectAtIndex:1] year]];
                    day2HighTempLabel.text = [NSString stringWithFormat:@"High Temperature: %@°F", [(ForecastDay *) [forecast objectAtIndex:1] high]];
                    day2LowTempLabel.text = [NSString stringWithFormat:@"Low Temperature: %@°F", [(ForecastDay *) [forecast objectAtIndex:1] low]];
                    day2DescriptionLabel.text = [NSString stringWithFormat:@"%@", [(ForecastDay *) [forecast objectAtIndex:1] conditions]];
                }
                if ([[forecast objectAtIndex:2] isKindOfClass:[ForecastDay class]]) {
                    day3DateLabel.text = [NSString stringWithFormat:@"%@/%@/%@", [(ForecastDay *) [forecast objectAtIndex:2] month], [(ForecastDay *) [forecast objectAtIndex:2] day], [(ForecastDay *) [forecast objectAtIndex:2] year]];
                    day3HighTempLabel.text = [NSString stringWithFormat:@"High Temperature: %@°F", [(ForecastDay *) [forecast objectAtIndex:2] high]];
                    day3LowTempLabel.text = [NSString stringWithFormat:@"Low Temperature: %@°F", [(ForecastDay *) [forecast objectAtIndex:2] low]];
                    day3DescriptionLabel.text = [NSString stringWithFormat:@"%@", [(ForecastDay *) [forecast objectAtIndex:2] conditions]];
                }
            });
        }
    }];
}

@end
