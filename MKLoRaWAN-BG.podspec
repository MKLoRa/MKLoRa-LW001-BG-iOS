#
# Be sure to run `pod lib lint MKLoRaWAN-BG.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKLoRaWAN-BG'
  s.version          = '1.0.0'
  s.summary          = 'A short description of MKLoRaWAN-BG.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/aadyx2007@163.com/MKLoRaWAN-BG'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/MKLoRa/MKLoRa-LW001-BG-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

#  s.source_files = 'MKLoRaWAN-BG/Classes/**/*'
  
  s.resource_bundles = {
    'MKLoRaWAN-BG' => ['MKLoRaWAN-BG/Assets/*.png']
  }

  s.subspec 'ApplicationModule' do |ss|
    ss.source_files = 'MKLoRaWAN-BG/Classes/ApplicationModule/**'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKLoRaWAN-BG/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'DatabaseManager' do |ss|
    ss.source_files = 'MKLoRaWAN-BG/Classes/DatabaseManager/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'FMDB'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKLoRaWAN-BG/Classes/SDK/**'
    
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKLoRaWAN-BG/Classes/Target/**'
    
    ss.dependency 'MKLoRaWAN-BG/Functions'
  end
  
  s.subspec 'ConnectModule' do |ss|
    ss.source_files = 'MKLoRaWAN-BG/Classes/ConnectModule/**'
    
    ss.dependency 'MKLoRaWAN-BG/SDK'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'Cell' do |sss|
      sss.subspec 'TextButtonCell' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Expand/Cell/TextButtonCell/**'
        
        ssss.dependency 'MKBaseModuleLibrary'
        ssss.dependency 'MKCustomUIModule'
      end
    end
    
    ss.subspec 'MKBGNormalAdopter' do |sss|
      sss.source_files = 'MKLoRaWAN-BG/Classes/Expand/MKBGNormalAdopter/**'
      
      sss.dependency 'MKBaseModuleLibrary'
      sss.dependency 'MKCustomUIModule'
    end
    
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AboutPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/AboutPage/Controller/**'
      end
    end
    
    ss.subspec 'ActiveStatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/ActiveStatePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/ActiveStatePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/ActiveStatePage/Model/**'
      end
    end
    
    ss.subspec 'AuxoliaryPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/AuxoliaryPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/DownlinkPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/VibrationPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/ManDownPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/ActiveStatePage/Controller'
      end
    end
    
    ss.subspec 'AxisSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/AxisSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/AxisSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/AxisSettingPage/Model/**'
      end
    end
    
    ss.subspec 'BlePositionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/BlePositionPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/BlePositionPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/FilterCondition/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/BlePositionPage/Model/**'
      end
      
    end
    
    ss.subspec 'BleSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/BleSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/BleSettingsPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/BroadcastSettingsPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/BleSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'BroadcastSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/BroadcastSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/BroadcastSettingsPage/Model'
        ssss.dependency 'MKLoRaWAN-BG/Functions/BroadcastSettingsPage/View'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/BroadcastSettingsPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/BroadcastSettingsPage/View/**'
      end
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/DeviceInfoPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/DeviceInfoPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/UpdatePage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/DeviceInfoPage/Model/**'
      end
      
    end
    
    ss.subspec 'DeviceModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/DeviceModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/TimingModePage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/PeriodicModePage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/MotionModePage/Controller'
      end
    end
    
    ss.subspec 'DevicePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/DevicePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/DevicePage/Model'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/SynDataPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/IndicatorSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/OnOffSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/DeviceInfoPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/DevicePage/Model/**'
      end
      
    end
    
    ss.subspec 'DownlinkPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/DownlinkPage/Controller/**'
      end
    end
    
    ss.subspec 'FilterCondition' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/FilterCondition/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/FilterCondition/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/FilterCondition/Model/**'
      end
    end
    
    ss.subspec 'GeneralPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/GeneralPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/GeneralPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/DeviceModePage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/AuxoliaryPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/BleSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/AxisSettingPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/GeneralPage/Model/**'
      end
      
    end
    
    ss.subspec 'GPSPositionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/GPSPositionPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/GPSPositionPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/GPSPositionPage/Model/**'
      end
      
    end
    
    ss.subspec 'IndicatorSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/IndicatorSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/IndicatorSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/IndicatorSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaApplicationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/LoRaApplicationPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/LoRaApplicationPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/LoRaApplicationPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/LoRaPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/LoRaPage/Model'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/LoRaSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/LoRaApplicationPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/LoRaPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/LoRaSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/LoRaSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/LoRaSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'ManDownPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/ManDownPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/ManDownPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/ManDownPage/Model/**'
      end
      
    end
    
    ss.subspec 'MotionModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/MotionModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/MotionModePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/MotionModePage/Model/**'
      end
      
    end
    
    ss.subspec 'OnOffSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/OnOffSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/OnOffSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/OnOffSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'PeriodicModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/PeriodicModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/PeriodicModePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/PeriodicModePage/Model/**'
      end
      
    end
    
    ss.subspec 'PositionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/PositionPage/Controller/**'
                
        ssss.dependency 'MKLoRaWAN-BG/Functions/WifiPositionPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/BlePositionPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/GPSPositionPage/Controller'
      end
      
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/ScanPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/ScanPage/Model'
        ssss.dependency 'MKLoRaWAN-BG/Functions/ScanPage/View'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/TabBarPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/ScanPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/ScanPage/View/**'
        ssss.dependency 'MKLoRaWAN-BG/Functions/ScanPage/Model'
      end
    end
    
    ss.subspec 'SynDataPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/SynDataPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/SynDataPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/SynDataPage/View/**'
      end
    end
    
    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/TabBarPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/LoRaPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/PositionPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/GeneralPage/Controller'
        ssss.dependency 'MKLoRaWAN-BG/Functions/DevicePage/Controller'
      end
    end
    
    ss.subspec 'TimingModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/TimingModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/TimingModePage/Model'
        ssss.dependency 'MKLoRaWAN-BG/Functions/TimingModePage/View'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/TimingModePage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/TimingModePage/View/**'
      end
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/UpdatePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/UpdatePage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/UpdatePage/Model/**'
      end
    end
    
    ss.subspec 'VibrationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/VibrationPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/VibrationPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/VibrationPage/Model/**'
      end
    end
    
    ss.subspec 'WifiPositionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/WifiPositionPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-BG/Functions/WifiPositionPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-BG/Classes/Functions/WifiPositionPage/Model/**'
      end
    end
    
    ss.dependency 'MKLoRaWAN-BG/SDK'
    ss.dependency 'MKLoRaWAN-BG/DatabaseManager'
    ss.dependency 'MKLoRaWAN-BG/CTMediator'
    ss.dependency 'MKLoRaWAN-BG/ConnectModule'
    ss.dependency 'MKLoRaWAN-BG/Expand'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    ss.dependency 'iOSDFULibrary'
    
  end
  
end
