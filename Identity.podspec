Pod::Spec.new do |spec|
  spec.name = "Identity"
  spec.version = "0.3.0"
  spec.summary = "Type-safe identifiers in Swift."
  spec.description = "A small library that makes it easy to create type-safe identifiers in Swift"
  spec.homepage = "https://github.com/JohnSundell/Identity"
  spec.license = { :type => "MIT", :file => "LICENSE" }
  spec.author = { "John Sundell" => "john@sundell.co" }
  spec.source = { :git => "https://github.com/JohnSundell/Identity.git", :tag => "#{spec.version}" }
  spec.source_files = "Sources/Identity/*.swift"
  spec.ios.deployment_target = "9.0"
  spec.osx.deployment_target = "10.9"
  spec.watchos.deployment_target = "3.0"
  spec.tvos.deployment_target = "9.0"
end