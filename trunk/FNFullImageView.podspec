

Pod::Spec.new do |s|
  s.name             = 'FNFullImageView'
  s.version          = '0.1.1'
  s.summary          = 'A short description of FNFullImageView.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/FNFullImageView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { ‘贾睿’ => 'jiaruijj@163.com' }
  s.source           = { :git => "https://github.com/jiaruijj/FNFullImageView.git" }

  s.ios.deployment_target = '7.0'
  s.source_files = 'FNFullImageView/Classes/**/*.{h,m}'
  #s.resources = 'FNFullImageView/Assets/*.png'
  s.resource_bundles = {
     'FNFullImageView' => ['FNFullImageView/Assets/*.png'],
  }
  s.dependency 'SDWebImage'
  s.dependency 'FNKit', '~> 0.1.2'


end
