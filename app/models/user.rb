class User < ApplicationRecord
  validates :device_id, :nickname,  presence: true
  validates :device_id, :nickname, uniqueness: true
  has_many :conversations, :foreign_key => :sender_id
end
