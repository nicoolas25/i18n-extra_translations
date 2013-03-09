module I18n
  class ExtraTranslations
    class Store < Hash
      def use(l, k, o) ; add_key(l, k , o, :used) end
      def miss(l, k, o) ; add_key(l, k, o, :missing) end

      def used?(keys)
        keys.inject(self){ |h, k| h.kind_of?(Hash) ? h[k] : (break h[k]) } == :used rescue false
      end

      protected

        def add_key(l, k, o, value)
          keys = I18n.normalize_keys(l, k, o[:scope]).dup
          l    = keys.pop.to_s
          h    = keys.inject(self) { |h, k| h.key?(k.to_s) ? h[k.to_s] : (h[k.to_s] = {}) }
          h[l] = value
        end
    end
  end
end
