# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'span_adt/version'

Gem::Specification.new do |spec|
  spec.name          = "span_adt"
  spec.version       = SpanAdt::VERSION
  spec.authors       = ["liyijie"]
  spec.email         = ["liyijie825@gmail.com"]
  spec.description   = %q{This is a adt client for span outum.}
  spec.summary       = %q{This is a adt client for span outum.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
