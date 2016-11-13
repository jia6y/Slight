# -*- encoding: utf-8
$:.unshift File.expand_path('../lib', __FILE__)
require 'slight'

Gem::Specification.new do |gem|
      gem.authors       = ["oliver.yu"]
      gem.email         = ["nemo1023@gmail.com"]
      gem.description   = %q{A light and sweet template language}
      gem.summary       = %q{The goal of this is to use ruby syntax and html style shotcut to write template.}
      gem.homepage      = ""
      gem.files         = `git ls-files`.split($\)
      #gem.files         = dir('.')
      #gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) unless f.end_with? ".rb" }
      gem.executables   = ["slsh","slight"]
      #gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
      gem.test_files    = ["spec"]
      gem.name          = "slight-lang"
      gem.require_paths = ["lib"]
      gem.version       = Slight::VERSION
      gem.license       = "MIT"
end
