# Uncomment this line to define a global platform for your project
# Uncomment this line if you're using Swift


#use_frameworks!
platform :ios, '9.0'


target 'SAD' do
    use_frameworks!

    pod 'FacebookCore'
    pod 'FacebookLogin'
    pod 'FacebookShare'
    pod 'Marshal', :git => 'https://github.com/utahiosmac/Marshal.git'
#    pod 'RealmSwift', :git => 'https://github.com/realm/realm-cocoa.git', :branch => 'master', :submodules => true
    pod 'RealmSwift'
    pod 'Charts', :git => 'https://github.com/danielgindi/Charts.git', :branch => 'master'
    pod 'DatePickerDialog'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0.1'
        end
    end
end
