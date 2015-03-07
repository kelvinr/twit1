class User < ActiveRecord::Base
  has_many :statuses

  validates :username, presence: true
  validates :email , presence: true
  validates :password, presence: true, length: {minimum: 5}

  has_secure_password
end