module I18n
  class ExtraTranslations
    class Server
      def call(env)
        [ 200, { "Content-Type" => "text/plain" }, [ mt_view(I18n::ExtraTranslations.missing_translations) ] ]
      end

      protected

      def mt_view(mt)
        if mt.nil? || mt.empty?
          'No missing translations found' if mt.nil? || mt.empty?
        else
          mt.join('\n')
        end
      end
    end
  end
end
