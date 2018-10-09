Pod::Spec.new do |s|
  s.name             = 'CivicConnect'
  s.version          = '0.1.0'
  s.summary          = 'An easy way to integrate your iOS app with the Civic Secure Identity App.'
  s.description      = <<-DESC
This library allows your iOS application to connect with the Civic Secure Identity App to authenticate users for specific information. More description coming soon.
                       DESC

  s.homepage         = 'https://github.com/civicteam/ios-civic-connect'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Civic Technologies' => 'support@civic.com' }
  s.source           = { :git => 'git@github.com:civicteam/ios-civic-connect.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'CivicConnect/Classes/**/*'

  s.resource_bundles = {
    'CivicConnect' => ['CivicConnect/Assets/*.png']
  }

  s.framework = 'Security'

end
