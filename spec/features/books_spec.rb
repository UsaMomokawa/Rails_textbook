require 'rails_helper'

RSpec.feature "Books", type: :feature, js: true do
  # ユーザーが新しい本を登録する
  scenario "user creates a new book" do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit root_path

    expect {
      click_link I18n.t(:'helpers.action.book.new')
      fill_in I18n.t(:'activerecord.attributes.book.title'), with: "太郎物語"
      fill_in I18n.t(:'activerecord.attributes.book.memo'), with: "太郎の感動的な物語"
      fill_in I18n.t(:'activerecord.attributes.book.author'), with: "太郎"
      attach_file I18n.t(:'activerecord.attributes.book.picture'), "#{Rails.root}/spec/factories/test_book.png"
      click_button I18n.t(:'helpers.submit.book.create')

      expect(page).to have_content I18n.t(:'flash.book.created')
      expect(page).to have_content "太郎物語"
    }.to change(Book, :count).by(1)

  end

  # ユーザーが本の詳細画面を見る
  scenario "user checks the book information" do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    login_as(user, :scope => :user)
    visit root_path

    click_link I18n.t(:'helpers.action.book.show')

    expect(page).to have_content book.title
  end

  # ユーザーが本の情報を更新する
  scenario "user updates the book information" do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    login_as(user, :scope => :user)
    visit root_path

    within find('tbody') do
      click_link I18n.t(:'helpers.action.book.edit')
    end

    fill_in I18n.t(:'activerecord.attributes.book.title'), with: "太郎物語"
    fill_in I18n.t(:'activerecord.attributes.book.memo'), with: "太郎の感動的な物語"
    fill_in I18n.t(:'activerecord.attributes.book.author'), with: "太郎"
    attach_file I18n.t(:'activerecord.attributes.book.picture'), "#{Rails.root}/spec/factories/test_anotherbook.png"
    click_button I18n.t(:'helpers.submit.book.update')

    expect(page).to have_content I18n.t(:'flash.book.updated')
    expect(page).not_to have_content book.title
    expect(page).to have_content "太郎物語"
  end

  # ユーザーが本を削除する
  scenario "user deletes a book" do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    login_as(user, :scope => :user)
    visit root_path

    click_link I18n.t(:'helpers.submit.book.destroy')
    page.accept_confirm

    expect(page).to have_content I18n.t(:'flash.book.destroyed')
    expect(page).not_to have_content book.title
  end
end
