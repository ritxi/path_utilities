# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'path_utilities/version'

Gem::Specification.new do |spec|
  spec.name          = 'path_utilities'
  spec.version       = PathUtilities::VERSION
  spec.authors       = ['Ricard Forniol Agustí']
  spec.email         = ['rforniol@path.travel']

  spec.summary       = %q{Libraries and common used development strategies}
  spec.description   = %q{At this moment includes a form validator strategy}
  spec.homepage      = 'http://github.com/3mundi/path_utilities'
  spec.license       = 'MIT'

  files = ->(f) { f.match(%r{^(test|spec|features)/}) }
  spec.files         = `git ls-files -z`.split("\x0").reject(&files)
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-its'

  spec.add_dependency 'activemodel', '~> 4.2'
  spec.add_dependency 'activesupport', '~> 4.2'
  spec.add_dependency 'virtus', '~> 1'
  spec.add_dependency 'mongoid', '~> 4'
end
