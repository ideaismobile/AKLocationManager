//
// AKLocationManager.h
//
// Created by Thiago Peres on 10/6/12.
// Copyright (c) 2012 Thiago Peres - Appkraft.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//

#import <CoreLocation/CoreLocation.h>

extern NSString *const kAKLocationManagerErrorDomain;

typedef void (^LocationUpdateBlock)(CLLocation *location);
typedef void (^LocationFailedBlock)(NSError *error);

typedef NS_ENUM(NSInteger, AKLocationManagerErrorType){
    AKLocationManagerErrorTimeout = 0,
    AKLocationManagerErrorCannotLocate = 1
};

@interface AKLocationManager : CLLocationManager <CLLocationManagerDelegate>

// ATENTION: These setters should be called before you call startLocationWithUpdateBlock
+ (void)setDistanceFilterAccuracy:(CLLocationAccuracy)accuracy;
+ (void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy;

/**
 *  The timeout time interval.
 *  
 *  This timeout interval will only be respected if the location manager does
 *  not get any updates or error.
 *
 *  The default value of this property is 10.0f.
 */
+ (void)setTimeoutTimeInterval:(NSTimeInterval)timeInterval;

//
// Initializes a location manager instance, manages the delegate and calls
// the update or failed block. Blocks will only be called once, then it will stop
// updating.
//
// To get called only on an accurate measurement, use the distance filter property
// in the .m
//
/**
 *  Initializes the location manager, handles the delegate and calls the
 *  update or failed block. Blocks will only be called once, then it will stop updating.
 *
 *  @param didUpdate The location update block.
 *  @param didFail   THe location failure block.
 */
+ (void)startLocatingWithUpdateBlock:(LocationUpdateBlock)didUpdate
                         failedBlock:(LocationFailedBlock)didFail;

/**
 *  Stops the generation of location updates.
 */
+ (void)stopLocating;

/**
 *  Checks if the app is authorized to use location services
 *  and if location services are enabled
 *
 *  @return Returns YES if both conditions are met, otherwise NO.
 */
+ (BOOL)canLocate;

/**
 *  Returns the most recent coordinate from the location manager instance
 *
 *  Will return CLLocationCoordinate2D if the locationManager hasn't been
 *  activated yet.
 */
+ (CLLocationCoordinate2D)mostRecentCoordinate;

@end
