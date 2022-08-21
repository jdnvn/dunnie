class User < ApplicationRecord
  has_and_belongs_to_many :rooms

  has_secure_password

  validates_presence_of :username
  validates_uniqueness_of :username
end
