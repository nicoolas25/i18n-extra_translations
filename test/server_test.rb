require 'test_helper'

describe I18n::ExtraTranslations::Server do
  let(:server) { I18n::ExtraTranslations::Server.new }
  let(:env)    { {} }
  before       { I18n::ExtraTranslations.extra_translations = I18n::ExtraTranslations::Store.new }

  describe '#call(env)' do
    it 'returns a 200 status code' do
      code, _, _ = server.call(env)
      code.must_equal 200
    end

    it 'have an text/plain content-type header' do
      _, headers, _ = server.call(env)
      headers['Content-Type'].must_equal 'text/plain'
    end

    describe 'when there is no missing translations' do
      it 'returns a body containing a message' do
        _, _, body_parts = server.call(env)
        body_parts.join.must_match /no missing translations found/i
      end
    end

    describe 'when there is some missing translations' do
      before { I18n::ExtraTranslations.extra_translations.miss(:en, 'foo', scope: 'bar.bar') }

      it 'returns a body containing the missing translation' do
        _, _, body_parts = server.call(env)
        body_parts.join.must_match 'en.bar.bar.foo'
      end
    end

    describe 'when the translation was missing before but was added since' do
      before do
        I18n::ExtraTranslations.extra_translations.miss(:en, 'foo', scope: 'bar.bar')
        I18n.load_path << File.expand_path('../fixtures/en.yml', __FILE__)
        I18n.backend.reload!
      end

      it 'does not return the missing translation' do
        _, _, body_parts = server.call(env)
        body_parts.join.wont_match 'en.bar.bar.foo'
      end

      after do
        I18n.load_path = []
        I18n.backend.reload!
      end
    end
  end
end
