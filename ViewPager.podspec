#
#  Be sure to run `pod spec lint ViewPager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  
  s.name   = 'ViewPager'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'ViewPager'
  s.homepage = 'https://github.com/blkbrds/ViewPager-iOS.git'
  s.authors  = { 'Su Ho V.' => 'su.ho@asiantech.vn' }
  s.source   = { :git => 'https://github.com/blkbrds/ViewPager-iOS.git', :tag => s.version}
  s.requires_arc = true
  s.ios.deployment_target = '9.0'
  s.ios.frameworks = 'UIKit'
  s.source_files = 'TabbarCustom/*.swift'
  
  end
  