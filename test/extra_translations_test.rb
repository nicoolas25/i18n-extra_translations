require 'test_helper'

describe I18n::ExtraTranslations do
  let(:et) { I18n::ExtraTranslations }

  describe '.extra_translations' do
    subject { et.extra_translations }

    it 'is an I18n::ExtraTranslations::Store instance' do
      subject.must_be_kind_of I18n::ExtraTranslations::Store
    end

    it 'is empty by default' do
      subject.must_be_empty
    end
  end

  describe '.locale' do
    subject { et.locale }

    it 'is a Symbol' do
      subject.must_be_kind_of Symbol
    end

    it 'is the i18n default locale by default' do
      subject.must_equal I18n.default_locale
    end
  end

  let(:filenames) { [File.expand_path('../fixtures/en.yml', __FILE__)] }
  let(:args)      { [:en, 'foo', {scope: 'bar.bar'}] }

  describe '.unused_translations(filenames)' do
    subject { et.unused_translations(filenames) }

    describe 'when no key are used' do
      it 'returns all the keys' do
        subject.must_equal({ filenames.first => ['en.bar.bar.foo', 'en.bar.bar.bar'] })
      end
    end

    describe 'when there is some used keys' do
      before { et.extra_translations.use(*args) }

      it 'returns the translations that are not used' do
        subject.must_equal({ filenames.first => ['en.bar.bar.bar'] })
      end
    end
  end

  describe '.missing_translations' do
    subject { et.missing_translations }

    before { et.extra_translations.miss(*args) }

    it 'returns all the keys from the store that have been marked missing' do
      subject.must_equal([ 'en.bar.bar.foo' ])
    end
  end
end
