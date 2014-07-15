# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'file_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "file_logger"
  spec.version       = FileLogger::VERSION
  spec.authors       = ["Tatumaki"]
  spec.email         = ["Tatumaki.x.euphoric@gmail.com"]
  spec.summary       = %q{File Logger is the easiest way to output log files.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "color_print"

end
