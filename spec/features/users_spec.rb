require 'rails_helper'

RSpec.feature "Users", type: :feature do
  # ユーザーが通常サインアップする
  scenario "user sign up with name, email, password, and avatar" do
    visit root_path
    click_link I18n.t(:'devise.shared.links.sign_up')
    fill_in I18n.t(:'activerecord.attributes.user.name'), with: "Test Name"
    fill_in I18n.t(:'activerecord.attributes.user.email'), with: "test@example.com"
    fill_in I18n.t(:'activerecord.attributes.user.password'), with: "hogehogetest"
    fill_in I18n.t(:'activerecord.attributes.user.password_confirmation'), with: "hogehogetest"
    attach_file I18n.t(:'activerecord.attributes.user.avatar'), "#{Rails.root}/spec/factories/test_avatar.png"
    click_button I18n.t(:'devise.shared.links.sign_up')

    expect(page).to have_content I18n.t(:'devise.registrations.signed_up')
    expect(page).to have_content "Test Name"
  end

  # ユーザーが通常ログインする
  scenario "user log in Books App" do
    user = FactoryBot.create(:user)

    visit root_path
    fill_in I18n.t(:'activerecord.attributes.user.email'), with: user.email
    fill_in I18n.t(:'activerecord.attributes.user.password'), with: user.password
    click_button I18n.t(:'devise.shared.links.sign_in')

    expect(page).to have_content I18n.t(:'helpers.action.book.index')
    expect(page).to have_content user.name
  end

  # ユーザーがユーザー情報を編集する
  scenario "user updates own user information" do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit root_path

    click_link I18n.t(:'helpers.action.user.edit')
    fill_in I18n.t(:'activerecord.attributes.user.name'), with: "Changed Name"
    fill_in I18n.t(:'activerecord.attributes.user.email'), with: "changed@example.com"
    fill_in I18n.t(:'activerecord.attributes.user.password'), with: "foofootest"
    fill_in I18n.t(:'activerecord.attributes.user.password_confirmation'), with: "foofootest"
    attach_file I18n.t(:'activerecord.attributes.user.avatar'), "#{Rails.root}/spec/factories/test_anotheravatar.png"
    click_button I18n.t(:'devise.registrations.edit.update')

    expect(page).to have_content I18n.t(:'devise.registrations.updated')
    expect(page).to have_content "Changed Name"
  end

  # ユーザーがログアウトする
  scenario "user log out Books App" do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit root_path

    click_link I18n.t(:'helpers.submit.user.log_out')
    expect(page).to have_content I18n.t(:'devise.sessions.signed_out')
  end

  # ユーザーをアカウントを削除する
  scenario "user deletes own account" do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit root_path

    click_link I18n.t(:'helpers.action.user.edit')

    expect{
      click_button I18n.t(:'devise.registrations.edit.cancel_my_account')

      page.accept_confirm
      expect(page).to have_content I18n.t(:'devise.registrations.destroyed')
    }.to change(User, :count).by(-1)
  end
end
