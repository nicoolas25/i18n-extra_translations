module I18n
  class ExtraTranslations
    class Server
      def call(env)
        reload_mt(I18n::ExtraTranslations.missing_translations)
        [ 200, { "Content-Type" => "text/plain" }, [ mt_view(I18n::ExtraTranslations.missing_translations) ] ]
      end

      protected

      def reload_mt(mt)
        return unless mt.kind_of? Array
        I18n.backend.reload!
        mt.each do |key|
          keys = key.split('.') ; keys.shift
          I18n.translate(keys.join('.'))
        end
      end

      def mt_view(mt)
        if mt.nil? || mt.empty?
          'No missing translations found' if mt.nil? || mt.empty?
        else
          mt.join("\n")
        end
      end
    end
  end
end
