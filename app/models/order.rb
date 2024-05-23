class Order < ApplicationRecord
  include StatusTrackable

  belongs_to :user
  belongs_to :product, required: true

  validates :amount, presence: true
  validates :user_id, presence: true
  validates :product_id, presence: true

  scope :processing, -> { where(status: :processing) }
  scope :accepted, -> { where(status: :accepted) }
  scope :denied, -> { where(status: :denied) }

  scope :completed, -> { where.not(status: :processing) }
  scope :uncompleted, -> { where(status: :processing) }
end
