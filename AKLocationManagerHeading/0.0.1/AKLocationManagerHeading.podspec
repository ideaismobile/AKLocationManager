#
#  Be sure to run `pod spec lint AKLocationManagerHeading.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "AKLocationManagerHeading"
  s.version      = "0.0.1"
  s.summary      = 'Simple CLLocationManager subclass with block support and convenience methods.'
  s.author       = { "Boska" => "mr.boska@gmail.com" }
  s.homepage     = "https://github.com/boska/AKLocationManager"
  s.license      = "MIT"
  s.source       = { :git => "https://github.com/boska/AKLocationManager.git", :tag => "0.0.1" }
  s.platform     = :ios
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.framework  = 'CoreLocation'
  s.requires_arc = true
end
