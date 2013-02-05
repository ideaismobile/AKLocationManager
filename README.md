AKLocationManager leverages the implementation of delegates to handle simple scenarios where you just want a quick way to get the user's current coordinate.

This class uses ARC

# How to use

Just call + (void)startLocatingWithUpdateBlock:(LocationUpdateBlock)didUpdate failedBlock:(LocationFailedBlock)didFail; it will check for authorization status and if location services is turned on, it will also fire a timeout timer.

    [AKLocationManager startLocatingWithUpdateBlock:^(CLLocation *location){
        // location acquired
    }failedBlock:^(NSError *error){
        // something is wrong
    }];

# Todo

- Sample project
- Better customization