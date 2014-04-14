require 'test_helper'

describe I18n::ExtraTranslations::Store do
  let(:store) { I18n::ExtraTranslations::Store.new }
  let(:args)  { [:en, 'foo', {scope: 'bar.bar'}] }

  describe '#use(locale, key, options)' do
    it 'store the key as used' do
      store.use(*args)
      store['en']['bar']['bar']['foo'].must_equal :used
    end

    describe 'when the key isn\'t expected' do
      let(:unexpected_args) { [:en, 'foo.foo', {scope: 'bar.bar'}] }

      it 'raise an explicit error' do
        store.use(*args)
        assert_raises I18n::ExtraTranslations::UnexpectedTranslationError do
          store.use(*unexpected_args)
        end
      end
    end
  end

  describe '#miss' do
    it 'store the key as missing' do
      store.miss(*args)
      store['en']['bar']['bar']['foo'].must_equal :missing
    end
  end

  describe '#used?(keys)' do
    let(:keys) { ['en', 'bar', 'bar', 'foo'] }

    describe 'when the key is used' do
      before do
        store.use(*args)
      end

      it 'returns true' do
        store.used?(keys).must_equal true
      end
    end

    describe 'when the key is missing' do
      before do
        store.miss(*args)
      end

      it 'returns false' do
        store.used?(keys).must_equal false
      end
    end

    describe 'when the key is unknown' do
      it 'returns false' do
        store.used?(keys).must_equal false
      end
    end
  end
end
