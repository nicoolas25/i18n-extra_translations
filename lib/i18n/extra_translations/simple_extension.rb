module I18n
  class ExtraTranslations
    module SimpleExtension
      def translate(locale, key, options = {})
        if locale == I18n::ExtraTranslations.locale
          result = catch :exception do
            _val = super
            I18n::ExtraTranslations.extra_translations.use(locale, key, options)
            _val
          end
          if result.kind_of? I18n::MissingTranslation
            I18n::ExtraTranslations.extra_translations.miss(locale, key, options)
            throw :exception, result
          else
            result
          end
        else
          super
        end
      end
    end
  end
end
