class Product < ApplicationRecord
  belongs_to :user
  scope :sorted, -> { order(created_at: :desc) }
  mount_uploaders :product_avatars, ProductAvatarUploader
  validates :user_id, presence: true
  validates :product_name, presence: true
  validates :product_intro, presence: true, length: { maximum: 400 }
  validates :raw_material, presence: true
  validates :fee, presence: true, numericality: { only_integer: true }
  validates :expiration_date, presence: true
  validates :total_weight, presence: true, numericality: { only_float: true }
  validates :product_avatars, presence: true
  validate  :day_after_today
  validate  :product_avatars_limit
  paginates_per 8

  def day_after_today
    unless expiration_date.nil?
      if expiration_date < Date.today
        errors.add(:expiration_date, 'は本日以降の日付を入力してください')
      end
    end
  end

  def product_avatars_limit
    unless product_avatars.count <= 4
      errors.add(:product_avatars, 'は4枚までです')
    end
  end
end
