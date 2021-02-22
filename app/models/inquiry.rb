class Inquiry
  include ActiveModel::Model
  attr_accessor :name, :email, :message
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, :presence => { :message => 'を入力してください' }
  validates :email, length: { maximum: 191 },
                    format: { with: VALID_EMAIL_REGEX },
                    presence: { :message => 'を入力してください' }
  validates :message, presence: { :message => 'を入力してください' }
end
