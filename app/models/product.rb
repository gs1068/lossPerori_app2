class Product < ApplicationRecord
  belongs_to :user
  scope :sorted, -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :product_name, presence: true
  validates :product_intro, presence: true, length: { maximum: 400 }
  validates :raw_material, presence: true
  validates :fee, presence: true
  validates :expiration_date, presence: true
  validates :total_weight, presence: true
end
