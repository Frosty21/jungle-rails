class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true  
end