class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  validates :email,
  presence: true,
  uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true 
  validates :password, presence: true
  validates :password_confirmation, presence: true  
end