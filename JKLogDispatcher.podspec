Pod::Spec.new do |s|
  s.name         = 'JKLogDispatcher'
  s.platform     = :ios, '5.0'
  s.summary      = 'A more powerful NSLog()'
  s.version      = '1.0.1'
  s.author       = { "Jackie" => "fsjack@gmil.com" }

  s.homepage     = "https://github.com/fsjack/JKLoggerDispatcher"	
  s.source       = { :git => "https://github.com/fsjack/JKLoggerDispatcher.git", :tag => '1.0.1'}
  s.license      = 'MIT'
  s.requires_arc = true

  s.subspec 'Core' do |ss|
    ss.source_files = 'JKLogDispatcher/Core/*.{h,m}'
  end  

  s.subspec 'CocoaLumberjackModule' do |ss|
    ss.source_files = 'JKLogDispatcher/Modules/JKConsoleLoggerModule/*.{h,m}'
    ss.dependency 'CocoaLumberjack'
    ss.dependency 'JKLogDispatcher/Core'
  end

end
