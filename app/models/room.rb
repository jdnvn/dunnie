class Room < ApplicationRecord
  has_and_belongs_to_many :users

  scope :active, -> { where('expires_at > ?', Time.current) }
end
