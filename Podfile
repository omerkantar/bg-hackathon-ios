platform :ios, '9.3'
use_frameworks!

def all_pods
  pod 'Moya', '~> 11.0'
  pod 'ObjectMapper', '~> 3.1'
  pod 'AlamofireImage', '~> 3.3'
end

target 'getir' do
  use_frameworks!
  all_pods

  target 'getirTests' do
    inherit! :search_paths
  end

  target 'getirUITests' do
    inherit! :search_paths
  end

end
