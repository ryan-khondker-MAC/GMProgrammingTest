//
//  LocationViewController.m
//  WeatherAppTest
//
//  Created by Ryan on 4/12/18.
//  Copyright © 2018 Ryan. All rights reserved.
//

#import "LocationViewController.h"
#import "ForecastViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

@synthesize cityField, stateField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [cityField setDelegate:self];
    [stateField setDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual: @"ToForecastVC"]) {
        NSString * _Nullable cityInput = cityField.text;
        NSString * _Nullable stateInput = stateField.text;
        if (cityInput == Nil || stateInput == Nil) { return; }
        
        UIViewController * forecastVC = [segue destinationViewController];
        if ([forecastVC isKindOfClass: [ForecastViewController class]]) {
            ((ForecastViewController *) forecastVC).cityName = cityInput;
            ((ForecastViewController *) forecastVC).stateName = stateInput;
        }
        [[self view] endEditing:YES];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)viewWeatherPressed:(id)sender {
    NSString * _Nullable cityInput = cityField.text;
    NSString * _Nullable stateInput = stateField.text;
    if (cityInput == Nil || stateInput == Nil) { return; }
    [[self view] endEditing:YES];
    
    ForecastViewController *forecastVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForecastVC"];
    forecastVC.cityName = cityInput;
    forecastVC.stateName = stateInput;
    [self addChildViewController:forecastVC];
    [self.view addSubview:forecastVC.view];
    [forecastVC didMoveToParentViewController:self];
    [self showViewController:forecastVC sender:self];
    //[self performSegueWithIdentifier:@"ToForecastVC" sender:self];
}
@end
