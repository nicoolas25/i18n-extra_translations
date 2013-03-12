# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'i18n-extra_translations'
  gem.version       = '0.0.2'
  gem.authors       = ['Nicolas ZERMATI']
  gem.email         = ['nicoolas25@gmail.com']
  gem.description   = %q{Find missing and extra translations in Rails application.}
  gem.summary       = %q{Find missing and extra translations in Rails application.}
  gem.homepage      = 'https://github.com/nicoolas25/i18n-extra_translations'

  gem.files         = `git ls-files lib`.split($/)
  gem.test_files    = gem.files.grep(%r{^test/})
  gem.require_paths = ['lib']

  gem.add_dependency 'i18n', '~> 0.6.4'
end
