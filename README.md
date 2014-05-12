# I18n::ExtraTranslations

<a href="http://twitter.com/nicoolas25"><img src="http://www.pairprogramwith.me/assets/badge.svg" style="height:40px" title="We can pair on this!" /></a>

Find missing and extra translations in an application.

## Installation

Add this line to your application's Gemfile:

    gem 'i18n-extra_translations', require: false

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n-extra_translations

## Usage

### In development mode

The library includes a Rack-compatible class that allows you to see the missing keys.

In your `config/routes.rb` file or in your `config.ru` add something like this:

    if Rails.env == 'development'
      require 'i18n/extra_translations'
      mount I18n::ExtraTranslations::Server.new => '/i18n'
    end

After this, check the path `/i18n` to see the missed keys.

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

## Options

### Set the reference locale

By default extra\_translations focuses on the default locale only.
It means that any other locale will not be used for both missing and unused translations.
You can set the locale to use with the following code:

    I18n::ExtraTranslations.locale = :fr

### Unused translations for a specific file

By default the file used to find unused translations is `"./config/locales/#{locale}.yml"` where `locale` is the reference locale.
You can pass a list of filepaths to look when you call `I18n::ExtraTranslations.unused_translations`:

    locale_filepaths = ['./config/locales/en.yml', './config/locales/attributes.en.yml']
    I18n::ExtraTranslations.unused_translations(locale_filepaths)

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
