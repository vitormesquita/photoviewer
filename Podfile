# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

def common_pods
  #Utils
  pod 'Mextension'
  pod 'INSPullToRefresh' #OBJC
  pod 'Kingfisher'
  
  #Rx
  pod 'RxSwift'
  pod 'RxCocoa'

  #API
  pod 'Moya/RxSwift', '~> 14.0.0-beta.4'
end

target 'PhotoViewer' do
  common_pods
  
  target 'PhotoViewerTests' do
    pod 'Quick'
    pod 'Nimble'
    pod 'RxTest'
    pod 'RxBlocking'
    pod 'RxNimble', subspecs: ['RxBlocking', 'RxTest']
  end
end

target 'PhotoViewer-Local' do
  common_pods
  
  target 'PhotoViewerUITests' do
    pod 'Quick'
    pod 'Nimble'
  end
end
