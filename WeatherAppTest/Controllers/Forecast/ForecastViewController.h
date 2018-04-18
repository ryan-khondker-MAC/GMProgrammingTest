//
//  ForecastViewController.h
//  WeatherAppTest
//
//  Created by Ryan on 4/13/18.
//  Copyright © 2018 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastViewController : UIViewController
@property (nonatomic, assign) NSString *cityName;
@property (nonatomic, assign) NSString *stateName;

@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *day1DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *day1HighTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *day1LowTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *day1DescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *day2DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *day2HighTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *day2LowTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *day2DescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *day3DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *day3HighTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *day3LowTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *day3DescriptionLabel;

@end
