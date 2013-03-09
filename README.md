# I18n::ExtraTranslations

Find missing and extra translations in an application.

## Installation

Add this line to your application's Gemfile:

    gem 'i18n-extra_translations'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n-extra_translations

## Usage

The only usage described YET is for the test mode.

### At the end of your test suite

Add this code, or something close, to your `(test|spec)_helper.rb` :

    require 'i18n/extra_translations'
    at_exit do
      require 'awesome_print'
      puts 'Missing translations:'
      ap I18n::ExtraTranslations.missing_translations
      puts 'Unused translations:'
      ap I18n::ExtraTranslations.unused_translations
    end

## Credits

This gem is heavily inspired by Sven Fuchs's [missing\_translation gem](https://github.com/svenfuchs/i18n-missing_translations).

## Do not miss

There also [i18n\_tools](https://github.com/tkadauke/i18n_tools) that do the same kind of stuff that this gem with a different approach.
While this gem hooks on I18n methods, the i18n\_tools gem works by scanning your source code.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
