Pod::Spec.new do |s|
  s.name         = "AKLocationManagerWithHeading"
  s.version      = '1.0.4'
  s.summary      = 'Simple CLLocationManager subclass with block support and convenience methods.'
  s.homepage     = 'https://github.com/boska/AKLocationManager'
  s.license      = 'MIT'
  s.author       = { "thiagoperes" => "thiago@appkraft.net" }
  s.source       = { :git => 'https://github.com/boska/AKLocationManager.git', :tag => '1.0.4' }
  s.platform     = :ios
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.framework  = 'CoreLocation'
  s.requires_arc = true
end
