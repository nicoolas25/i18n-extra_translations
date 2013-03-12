require 'test_helper'

describe I18n::ExtraTranslations::Server do
  let(:server) { I18n::ExtraTranslations::Server.new }
  let(:env)    { {} }

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

      it 'returns a body containing a message' do
        _, _, body_parts = server.call(env)
        body_parts.join.must_match 'en.bar.bar.foo'
      end
    end
  end
end
