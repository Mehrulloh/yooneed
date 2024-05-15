class Product < ApplicationRecord
  has_one_attached :image
  has_many :orders, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :amount, presence: true

  scope :active?, -> { where(active: true) }

  enum packing_type: { piece: 0, boxes: 1, pack: 2 }
end

