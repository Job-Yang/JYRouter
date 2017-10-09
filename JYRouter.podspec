Pod::Spec.new do |s|
  s.name         = 'JYRouter'
  s.summary      = 'Router framework is based on runtime to push/present/pop/dismiss for iOS'
  s.version      = '2.1.1'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Job-Yang" => "578093143@qq.com" }
  s.homepage     = 'https://github.com/Job-Yang/JYRouter'
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/Job-Yang/JYRouter.git', :tag => s.version}
  
  s.requires_arc = true
  s.source_files = 'JYRouter/**/*.{h,m}'
  
end