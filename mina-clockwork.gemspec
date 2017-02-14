# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina/clockwork/version'

Gem::Specification.new do |spec|
  spec.name          = 'mina-clockwork'
  spec.version       = Mina::Clockwork::VERSION
  spec.authors       = ['Alexey Chernenkov']
  spec.email         = ['laise@pisem.net']
  spec.summary       = 'Clockwork deployment scenario for mina.'
  spec.description   = ''
  spec.homepage      = 'https://github.com/907th/mina-clockwork'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'clockwork'
  spec.add_dependency 'daemons'
  spec.add_dependency 'mina', '>= 1.0.2'
end
