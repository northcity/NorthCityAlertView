#
# Be sure to run `pod lib lint NCAlertView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NCAlertView'
  s.version          = '1.0.2'
  s.summary          = '北城的弹框'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!


  s.homepage         = 'https://github.com/northcity/NorthCityAlertView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenxi' => '506343891@qq.com' }
  s.source           = { :git => 'https://github.com/northcity/NorthCityAlertView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'NCAlertView/Classes/**/*'
  s.resources    = 'NCAlertView/NCAlertViewBundle.bundle'
  
end
