//
//  LocationViewController.h
//  WeatherAppTest
//
//  Created by Ryan on 4/12/18.
//  Copyright © 2018 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *stateField;

- (IBAction)viewWeatherPressed:(id)sender;

@end

