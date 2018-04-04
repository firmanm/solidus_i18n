# encoding: utf-8

require 'spec_helper'

RSpec.feature 'Translations', :js do
  given(:language) { Spree.t(:this_file_language, scope: 'i18n', locale: 'pt-BR') }
  given(:store) { create(:store) }

  background do
    reset_spree_preferences
    store.update_attributes(preferred_available_locales: %i[en pt-BR])
  end

  context 'page' do
    context 'switches locale from the dropdown' do
      before do
        visit spree.root_path
        select(language, from: Spree.t(:language, scope: 'i18n'))
      end

      scenario 'selected translation is applied' do
        expect(page).to have_content(/#{Spree.t(:home, locale: 'pt-BR')}/i)
      end

      scenario 'JS cart link is translated' do
        expect(page).to have_content(/#{Spree.t(:cart, locale: 'pt-BR')}/i)
      end
    end
  end
end
