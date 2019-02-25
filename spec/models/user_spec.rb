require 'rails_helper'

RSpec.describe User, type: :model do
  # 名前、メール、パスワードがあれば有効な状態であること
  it 'is valid with an email and password' do
    user = User.new(
      name: '太郎',
      email: 'test@example.com',
      password: 'hogehogetest'
    )
    expect(user).to be_valid
  end

  # 名前がなければ無効な状態であること
  it 'is invalid without a name' do
    user = FactoryBot.build(:user, name:nil)
    user.valid?
    expect(user.errors[:name]).to include(I18n.t :'errors.messages.blank')
  end

  # メールアドレスがなければ無効な状態であること
  it 'is invalid without an email address' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include(I18n.t :'errors.messages.blank')
  end

  # パスワードがなければ無効な状態であること
  it 'is invalid without a password' do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include(I18n.t :'errors.messages.blank')
  end

  # 重複したメールアドレスなら無効な状態であること
  it 'is invalid with a duplicate email address' do
    email = 'test@example.com'
    User.create(
      name: '太郎',
      email: email,
      password: 'hogehogetest'
    )
    user = User.new(
      name: '次郎',
      email: email,
      password: 'hogehogetest'
    )
    user.valid?
    expect(user.errors[:email]).to include(I18n.t :'errors.messages.taken')
  end
end
