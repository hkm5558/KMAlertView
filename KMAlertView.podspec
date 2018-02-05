#
# Be sure to run `pod lib lint KMAlertView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KMAlertView'
  s.version          = '0.0.2'
  s.summary          = '一款自定义的AlertView 附带动画效果'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hkm5558/KMAlertView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hkm5558' => '15112600181@163.com' }
  s.source           = { :git => 'https://github.com/hkm5558/KMAlertView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KMAlertView/Classes/*'
  
  # s.resource_bundles = {
  #   'KMAlertView' => ['KMAlertView/Assets/*.png']
  # }

  s.public_header_files = 'KMAlertView/Classes/*.h'

    s.subspec 'KMAlertStyle' do |ss|
    ss.source_files = 'KMAlertView/Classes/KMAlertStyle/*.{h,m}'
    ss.public_header_files = 'KMAlertView/Classes/KMAlertStyle/*.h'
  end


  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
