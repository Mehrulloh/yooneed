class Product < ApplicationRecord
  has_one_attached :image

  enum status: { processing: 0, accepted: 1, denied: 2 }

  include Authorship

  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :user_id, presence: true

  scope :processing, -> { where(status: :processing) }
  scope :accepted, -> { where(status: :accepted) }
  scope :denied, -> { where(status: :denied) }

end
