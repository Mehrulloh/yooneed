class Order < ApplicationRecord
  include StatusTrackable

  belongs_to :user
  belongs_to :product

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :amount, presence: true
  validates :user_id, presence: true
  validates :product_id, presence: true

  scope :processing, -> { where(status: :processing) }
  scope :accepted, -> { where(status: :accepted) }
  scope :denied, -> { where(status: :denied) }

end
