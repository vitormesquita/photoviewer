# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'PhotoViewer' do
  use_frameworks!
  inhibit_all_warnings!

  #Utils
  pod 'Mextension'
  pod 'INSPullToRefresh' #OBJC
  pod 'Kingfisher'
  
  #Rx
  pod 'RxSwift'
  pod 'RxCocoa'

  #API
  pod 'Moya/RxSwift', '~> 14.0.0-beta.4'
  
  target 'PhotoViewerTests' do
    pod 'Quick'
    pod 'Nimble'
    pod 'RxTest'
    pod 'RxBlocking'
    pod 'RxNimble', subspecs: ['RxBlocking', 'RxTest']
  end
  
  target 'PhotoViewerUITests' do
    pod 'Quick'
    pod 'Nimble'
  end
end


