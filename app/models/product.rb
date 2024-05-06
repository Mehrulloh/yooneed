class Product < ApplicationRecord
  include StatusTrackable

  has_one_attached :image

  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :amount, presence: true
  validates :user_id, presence: true

  scope :processing, -> { where(status: :processing) }
  scope :accepted, -> { where(status: :accepted) }
  scope :denied, -> { where(status: :denied) }

  scope :active?, -> { where(active: true) }

end
