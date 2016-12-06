# Uncomment this line to define a global platform for your project
# Uncomment this line if you're using Swift


#use_frameworks!
platform :ios, '9.0'


target 'SAD' do
    use_frameworks!

    pod 'Marshal', :git => 'https://github.com/utahiosmac/Marshal.git'
    pod 'RealmSwift'
    pod 'Charts', :git => 'https://github.com/danielgindi/Charts.git', :branch => 'master'
    pod 'Firebase/Core'
    pod 'Firebase/Database'
    pod 'DatePickerDialog'
    pod “TPKeyboardAvoiding”

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0.1'
        end
    end
end
