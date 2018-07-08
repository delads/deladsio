class Cube < ActiveRecord::Base
  validates :sigfox_id, presence: true
end