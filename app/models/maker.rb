class Maker < ActiveRecord::Base
  has_many :sensors
  has_many :triggers
  has_many :access_grants, class_name: "Doorkeeper::AccessGrant", foreign_key: :resource_owner_id, dependent: :delete_all # or :destroy if you need callbacks
  has_many :access_tokens, class_name: "Doorkeeper::AccessToken", foreign_key: :resource_owner_id, dependent: :delete_all # or :destroy if you need callbacks
  
  before_save { self.email = email.downcase }
  validates :makername, presence: true, length: {minimum: 3, maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {minimum: 3, maximum: 105 },
                                    uniqueness: {case_sensitive: false},
                                    format: { with: VALID_EMAIL_REGEX }
 has_secure_password                                  
end