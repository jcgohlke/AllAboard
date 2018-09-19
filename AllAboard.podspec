Pod::Spec.new do |s|

  s.name     = "AllAboard"
  s.version  = "0.1.0"
  s.summary  = "An easy-to-configure onboarding UI control."
  s.homepage = ""
  s.license  = { :type => "GNU GPLv3", :file => "LICENSE" }

  s.author           = "Ben Gohlke"
  s.social_media_url = "http://twitter.com/FerrousGuy"

  s.platform              = :ios, "12.0"
  s.requires_arc          = true
  s.swift_version         = "4.2"

  s.source        = { :git => "http://EXAMPLE/AllAboard.git",
		      :tag => "#{s.version}" }
  s.source_files  = "AllAboard/**/*.{swift}"
  s.resources     = "AllAboard/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  s.framework     = "UIKit"

end
