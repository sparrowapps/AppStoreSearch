# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def podList
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'Cosmos', '~> 18.0'
end

target 'AppStoreSearch' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for AppStoreSearch
  podList

  target 'AppStoreSearchTests' do
    inherit! :search_paths
    # Pods for testing
    podList
  end

  target 'AppStoreSearchUITests' do
    inherit! :search_paths
    # Pods for testing
    podList
  end

end
