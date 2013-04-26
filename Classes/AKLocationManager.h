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

typedef enum {
    AKLocationManagerErrorTimeout = 0,
    AKLocationManagerErrorCannotLocate = 1,
} AKLocationManagerError;

@interface AKLocationManager : CLLocationManager <CLLocationManagerDelegate>

// ATENTION: These setters should be called before you call startLocationWithUpdateBlock

//
// The receiver does its best to achieve the requested accuracy; however,
// the actual accuracy is not guaranteed.
//
// You should assign a value to this property that is appropriate for your
// usage scenario. In other words, if you need the current location only within
// a few kilometers, you should not specify kCLLocationAccuracyBest for the accuracy.
//
// Determining a location with greater accuracy requires more time and more power.
//
// When requesting high-accuracy location data, it may take a long time before you get an update.
//
// The default value of this property is 2000.0f.
//
+ (void)setDistanceFilterAccuracy:(CLLocationAccuracy)accuracy;

// 
// Desired accuracy
//
// CLLocationAccuracy used to represent a location accuracy level in meters. The lower the value in meters, the
// more physically precise the location is. A negative accuracy value indicates an invalid location.
//
// The default value of this property is 3000.0.
// 
+ (void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy;

//
// Number of seconds to wait before timing out - default is 10
//
+ (void)setTimeoutTimeInterval:(NSTimeInterval)timeInterval;

//
// Initializes a location manager instance, manages the delegate and calls
// the update or failed block. Blocks will only be called once, then it will stop
// updating.
//
// To get called only on an accurate measurement, use the distance filter property
// in the .m
//
+ (void)startLocatingWithUpdateBlock:(LocationUpdateBlock)didUpdate
                         failedBlock:(LocationFailedBlock)didFail;

//
// Stops the generation of location updates.
//
// Neither the did update Block or the failure block will be called
// Also, the timeout timer will be invalidated
//
+ (void)stopLocating;

//
// Checks if the app is authorized to use location services
// Also checks if location services are enabled
//
// Returns YES if both conditions are met
//
+ (BOOL)canLocate;

//
// Returns the most recent coordinate from the location manager instance
//
// Will return CLLocationCoordinate2D if the locationManager hasn't been
// activated yet.
//
+ (CLLocationCoordinate2D)mostRecentCoordinate;

@end
