//
//  AKLViewController.h
//  AKLocationManagerDemo
//
//  Created by Thiago Peres on 2/5/13.
//  Copyright (c) 2013 Appkraft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AKLViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeoutLabel;
@property (weak, nonatomic) IBOutlet UISlider *accuracySlider;
@property (weak, nonatomic) IBOutlet UISlider *timeoutSlider;
@property (weak, nonatomic) IBOutlet UIButton *locateButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)accuracySliderValueChanged:(id)sender;
- (IBAction)timeoutSliderValueChanged:(id)sender;

- (IBAction)startLocatingButtonPressed:(id)sender;

@end
