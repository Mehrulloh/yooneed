class Product < ApplicationRecord
  include StatusTrackable

  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :amount, presence: true

  scope :active?, -> { where(active: true) }

  scope :processing, -> { where(status: :processing) }
end
