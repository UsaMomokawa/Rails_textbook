require 'rails_helper'

RSpec.feature "Omniauth", type: :feature do
  before do
    OmniAuth.config.mock_auth[:facebook] = nil
  end

  # ユーザーがFacebook認証でログインする
  scenario "authentication success" do
    visit root_path
    set_omniauth
    click_link I18n.t(:'devise.shared.links.sign_in_with_provider', provider: "Facebook")

    expect(page).to have_content I18n.t(:'helpers.action.book.index')
    expect(page).to have_content I18n.t(:'devise.omniauth_callbacks.success', kind: "Facebook")
    expect(page).to have_content "Mock User"
  end

  # Facebook認証に失敗する
  scenario "authentication error" do
    visit root_path
    set_invalid_omniauth
    click_link I18n.t(:'devise.shared.links.sign_in_with_provider', provider: "Facebook")

    expect(page).to have_content I18n.t(:'devise.omniauth_callbacks.failure', kind: "Facebook", reason: "Invalid credentials message")
  end
end
