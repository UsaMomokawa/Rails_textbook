require 'rails_helper'

RSpec.describe Book, type: :model do
  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryBot.build(:book)).to be_valid
  end

  # タイトル、著者名があれば有効であること
  it 'is valid with a title and an author name' do
    book = Book.new(
      title: '太郎物語',
      author: '太郎'
    )
    expect(book).to be_valid
  end

  # タイトルがなければ無効であること
  it 'is invalid without a title' do
    book = FactoryBot.build(:book, title: nil)
    book.valid?
    expect(book.errors[:title]).to include(I18n.t :'errors.messages.blank')
  end

  # 著者名がなければ無効であること
  it 'is invalid without an author name' do
    book = FactoryBot.build(:book, author: nil)
    book.valid?
    expect(book.errors[:author]).to include(I18n.t :'errors.messages.blank')
  end
end
