class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true

  mount_uploader :picture, PictureUploader
end
