# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

def common_pods
  pod 'Kingfisher', '~> 4.0'
  pod 'SDWebImage'
end

target 'NinjaOneProject' do
  common_pods
end  

target 'NinjaOneProjectTests' do
    inherit! :search_paths
    common_pods
    pod 'SnapshotTesting', '~> 1.8.1'
end

