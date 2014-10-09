Pod::Spec.new do |s|
  s.name         = 'JKLogDispatcher'
  s.platform     = :ios, '5.0'
  s.summary      = 'A more powerful NSLog()'
  s.version      = '1.0.0'
  s.author       = { "Jackie" => "fsjack@gmil.com" }

  s.homepage     = "https://github.com/fsjack/JKLoggerDispatcher"	
  s.source       = { :git => "https://github.com/fsjack/JKLoggerDispatcher.git", :tag => '1.0.0'}
  s.source_files = 'JKLogDispatcher/Core/*.{h,m}'
  s.license      = 'MIT'
  s.requires_arc = true

  s.subspec 'CocoaLumberjackLogger' do |ss|
    ss.source_files = 'JKLogDispatcher/Modules/JKConsoleLoggerModule/*.{h,m}'
    ss.dependency 'CocoaLumberjack'
  end

end
