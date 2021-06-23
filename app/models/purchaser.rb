class Purchaser < ApplicationRecord
  after_accessor :token
  belongs_to :user
  belongs_to :item
  has_one :address
end
