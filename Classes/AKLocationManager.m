//
// AKLocationManager.m
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

#import "AKLocationManager.h"

@implementation AKLocationManager

LocationUpdateBlock _locationDidUpdate;
LocationFailedBlock _locationDidFail;

static AKLocationManager *_locationManager = nil;
static NSTimer *_locationTimeoutTimer = nil;
static CLLocationDistance _distanceFilterAccuracy = 2000.0f;
static NSTimeInterval _timeoutTimeInterval = 10.0f;
static CLLocationAccuracy _desiredAccuracy = 3000.0f;

NSString *const kAKLocationManagerErrorDomain = @"AKLocationManagerErrorDomain";

//
// If you need logging, just uncomment the line below and comment AKLLog(...) inside #ifdef DEBUG
//
// If you want to disable logging completely, add #define AKLLog(...) to your prefix file
//
#ifdef DEBUG
#   ifndef AKLLog
#      define AKLLog(fmt, ...) NSLog((@"AKLocation - [Line %d] " fmt), __LINE__, ##__VA_ARGS__);
#   endif
#else
#   define AKLLog(...)
#endif

#pragma mark CLLocationManager Delegate

+ (void)setDistanceFilterAccuracy:(CLLocationAccuracy)accuracy
{
    _distanceFilterAccuracy = accuracy;
}

+ (void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy
{
    _desiredAccuracy = desiredAccuracy;
}

+ (void)setTimeoutTimeInterval:(NSTimeInterval)timeInterval
{
    _timeoutTimeInterval = timeInterval;
}

+ (void)startLocatingWithUpdateBlock:(LocationUpdateBlock)didUpdate
                         failedBlock:(LocationFailedBlock)didFail
{
    if (![AKLocationManager canLocate])
    {
        NSError *e = [NSError errorWithDomain:kAKLocationManagerErrorDomain
                                         code:AKLocationManagerErrorCannotLocate
                                     userInfo:nil];
        didFail(e);
        return;
    }
    
    _locationDidUpdate = didUpdate;
    _locationDidFail = didFail;
    
    if (!_locationManager)
    {
        _locationManager = [[AKLocationManager alloc] init];
    }
    
    _locationManager.distanceFilter = _distanceFilterAccuracy;
    _locationManager.desiredAccuracy = _desiredAccuracy;
    _locationManager.delegate = _locationManager;
    
    _locationTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:_timeoutTimeInterval
                                                             target:_locationManager
                                                           selector:@selector(timerEnded)
                                                           userInfo:nil
                                                            repeats:NO];
    [_locationManager startUpdatingLocation];
    
    AKLLog(@"\n Started locating\n ==============\n Distance filter accuracy: %.2f\n Desired accuracy: %.2f\n Timeout: %.2f", _distanceFilterAccuracy, _desiredAccuracy, _timeoutTimeInterval);
}

- (void)timerEnded
{
    AKLLog(@"Timer ended. Stopping AKLocationManager.");
    CLLocation *lastLoc = _locationManager.location;
    
    if ((lastLoc == nil) || (lastLoc.horizontalAccuracy > _distanceFilterAccuracy))
    {
        [_locationManager stopUpdatingLocation];
        
        NSError *error = [[NSError alloc] initWithDomain:kAKLocationManagerErrorDomain
                                                    code:AKLocationManagerErrorTimeout
                                                userInfo:nil];
        if (_locationDidFail)
        {
            _locationDidFail(error);
        }
    }
    _locationTimeoutTimer = nil;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    AKLLog(@"\n Did update location:\n %@\n Altitude: %f\n Vertical accuracy: %f\n\n", newLocation, newLocation.altitude, newLocation.verticalAccuracy);
    if (newLocation.horizontalAccuracy <= _desiredAccuracy && abs([newLocation.timestamp timeIntervalSinceNow]) < 15.0)
    {
        if (_locationTimeoutTimer)
        {
            [_locationTimeoutTimer invalidate];
            _locationTimeoutTimer = nil;
        }
        [manager stopUpdatingLocation];
        if (_locationDidUpdate)
        {
            _locationDidUpdate(newLocation);
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    AKLLog(@"Did fail getting location: %@", error);
    if (_locationTimeoutTimer)
    {
        [_locationTimeoutTimer invalidate];
        _locationTimeoutTimer = nil;
    }
    
    //
    // Stops locating if access to location
    // services was denied
    //
    if ((error.domain == kCLErrorDomain) &&
        (error.code == kCLErrorDenied))
    {
        [manager stopUpdatingLocation];
    }
    
    if (_locationDidFail)
    {
        _locationDidFail(error);
    }
}

+ (void)stopLocating
{
    if (_locationManager)
    {
        [_locationManager stopUpdatingLocation];
    }
    if (_locationTimeoutTimer)
    {
        [_locationTimeoutTimer invalidate];
    }
}

+ (BOOL)canLocate
{
    return (([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) ||
            ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined))
            && [CLLocationManager locationServicesEnabled];
}

+ (CLLocationCoordinate2D)mostRecentCoordinate
{
    CLLocation *loc = _locationManager.location;
    
    //
    // Verifies if mostRecentCoordinate location object is valid
    // according to behavioral specification in CLLocatioManager's
    // official documentation.
    //
    // See: https://developer.apple.com/library/mac/#documentation/CoreLocation/Reference/CLLocationManager_Class/CLLocationManager/CLLocationManager.html
    //
    if (loc == nil
        || [[NSDate date] timeIntervalSinceDate:loc.timestamp] >= 60
        || loc.horizontalAccuracy > _distanceFilterAccuracy
        || !CLLocationCoordinate2DIsValid(loc.coordinate))
    {
        return kCLLocationCoordinate2DInvalid;
    }
    
    return loc.coordinate;
}

@end
