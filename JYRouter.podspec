Pod::Spec.new do |s|
  s.name         = 'JYRouter'
  s.summary      = 'JYRouter是一个基于Routable封装的路由跳转库，封装了常见的Push, Pop, Present, Dismiss等跳转方法'
  s.version      = '1.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Job-Yang" => "578093143@qq.com" }
  s.homepage     = 'https://github.com/Job-Yang/JYRouter'
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/Job-Yang/JYRouter.git', :tag => s.version}
  
  s.requires_arc = true
  s.source_files = 'JYRouter/**/*.{h,m}'
  s.dependency 'YYModel'
  
end