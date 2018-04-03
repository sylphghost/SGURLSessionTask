Pod::Spec.new do |s|
  s.name         = 'SGURLSessionTask'
  s.summary      = 'An easy-to-use network encapsulation for iOS projects.'
  s.version      = '1.0.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'sylphghost' => 'sylphghost@outlook.com' }
  s.homepage     = 'https://github.com/sylphghost/SGURLSessionTask'
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/sylphghost/SGURLSessionTask.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'SGURLSessionTask/**/*.{h,m}'

  s.dependency 'AFNetworking', '~> 3.0'
  s.dependency 'YYModel'
  s.dependency 'PromiseKit', '~> 1.0'

end
