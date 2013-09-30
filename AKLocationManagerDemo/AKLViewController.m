//
//  AKLViewController.m
//  AKLocationManagerDemo
//
//  Created by Thiago Peres on 2/5/13.
//  Copyright (c) 2013 Appkraft. All rights reserved.
//

#import "AKLViewController.h"
#import "AKLocationManager.h"

@interface AKLViewController ()

@end

@implementation AKLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.accuracyLabel setText:[NSString stringWithFormat:@"%d", (int)self.accuracySlider.value]];
    [self.timeoutLabel setText:[NSString stringWithFormat:@"%.2f", self.timeoutSlider.value]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)accuracySliderValueChanged:(UISlider*)sender
{
    [self.accuracyLabel setText:[NSString stringWithFormat:@"%d", (int)self.accuracySlider.value]];
    [AKLocationManager setDesiredAccuracy:sender.value];
}

- (IBAction)timeoutSliderValueChanged:(UISlider*)sender {
    [self.timeoutLabel setText:[NSString stringWithFormat:@"%.2f", self.timeoutSlider.value]];
    [AKLocationManager setTimeoutTimeInterval:sender.value];
}

- (IBAction)startLocatingButtonPressed:(id)sender {
    //
    // We call stopLocating just in case there's a location request already being made
    //
    [AKLocationManager stopLocating];
    
    //
    // This is how we call it
    //
    [AKLocationManager startLocatingWithUpdateBlock:^(CLLocation* location){
        
        //
        // Do whatever you wanna do with the location object
        //
        // Keep in mind you DO NOT have to call stopLocating
        //
        NSLog(@"Location acquired.");
        
        [self.mapView setCenterCoordinate:location.coordinate animated:YES];
        
    }failedBlock:^(NSError *error){
        //
        // This block is also called if we get a timeout
        //
        
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:[error description]
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }];
}
@end
