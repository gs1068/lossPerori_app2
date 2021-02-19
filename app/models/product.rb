class Product < ApplicationRecord
  belongs_to :user
  scope :sorted, -> { order(created_at: :desc) }
  mount_uploaders :product_avatars, ProductAvatarUploader
  validates :user_id, presence: true
  validates :product_name, presence: true
  validates :product_intro, presence: true, length: { maximum: 400 }
  validates :raw_material, presence: true
  validates :fee, presence: true, numericality: { only_integer: true }
  validates :categories, presence: true
  validates :expiration_date, presence: true
  validates :total_weight, presence: true, numericality: { only_float: true }
  validates :product_avatars, presence: true
  validate  :day_after_today
  validate  :product_avatars_limit

  def self.search_free_word(search_free_waord)
    return Product.all unless search_free_waord
    Product.where([
      'product_name LIKE(?) OR
      product_intro LIKE(?) OR
      categories LIKE(?) OR
      raw_material LIKE(?)',
      "%#{search_free_waord}%",
      "%#{search_free_waord}%",
      "%#{search_free_waord}%",
      "%#{search_free_waord}%",
    ])
  end

  private

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
