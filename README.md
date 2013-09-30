AKLocationManager leverages the implementation of delegates to handle simple scenarios where you just want a quick way to get the user's current coordinate.

## Installation

### Via Cocoapods:

```bash
pod 'AKLocationManager'
```

### Manually:

- Download or clone the repository:

```bash
$ git clone git://github.com/appkraft/AKLocationManager.git
```

- Check out the sample project.

- Drag ```AKLocationManager.{h/m}``` into your project.

- Include the header file:

```objc
#import "AKLocationManager.h"
```

## Usage

- Call + (void)startLocatingWithUpdateBlock:(LocationUpdateBlock)didUpdate failedBlock:(LocationFailedBlock)didFail; it will check for authorization status and if location services is turned on, it will also fire a timeout timer.  

```objc
[AKLocationManager startLocatingWithUpdateBlock:^(CLLocation *location){
    // location acquired
}failedBlock:^(NSError *error){
    // something is wrong
}];
```

- Check the header file or sample project for a small documentation and other customization options.

**This class uses ARC.**

## License

AKLocationManager is licensed under the MIT License:

  Copyright (c) 2012 Thiago Peres (http://www.appkraft.net/)

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
