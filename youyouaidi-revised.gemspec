# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'youyouaidi-revised/version'

Gem::Specification.new do |spec|
  spec.name          = 'youyouaidi-revised'
  spec.version       = YouyouaidiRevised::VERSION
  spec.authors       = ['Nicolas Fricke', 'Loran Kloeze']
  spec.email         = ['mail@nicolasfricke.de', 'loran@freedomnet.nl']
  spec.summary       = 'UUID class'
  spec.description   = 'Youyouaidi offers a UUID class for parsing, validating and encoding UUIDs'
  spec.homepage      = 'https://github.com/LoranKloeze/youyouaidi-revised'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.4'

  spec.files         = Dir['lib/**/*'] + %w[LICENSE.txt README.md]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.5'
end
