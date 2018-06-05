class Sensor < ActiveRecord::Base
  belongs_to :maker
  has_many :triggers
  
  validates :maker_id, presence: true
  validates :name, presence: true, length: {minimum: 5, maximum: 100 }

end