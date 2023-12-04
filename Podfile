# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AITextRecognition' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

   # To recognize Latin script
pod 'GoogleMLKit/TextRecognition', '3.2.0'
## To recognize Chinese script
#pod 'GoogleMLKit/TextRecognitionChinese', '3.2.0'
## To recognize Devanagari script
#pod 'GoogleMLKit/TextRecognitionDevanagari', '3.2.0'
## To recognize Japanese script
#pod 'GoogleMLKit/TextRecognitionJapanese', '3.2.0'
## To recognize Korean script
#pod 'GoogleMLKit/TextRecognitionKorean', '3.2.0'

end
post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			xcconfig_path = config.base_configuration_reference.real_path
			xcconfig = File.read(xcconfig_path)
			xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
			File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
		end
	end
end
