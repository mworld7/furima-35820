class Item < ApplicationRecord
  vakidates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :postage_by_id, presence: true
  validates :ship_from_id, presence: true
  validates :shipping_date_id, presence: true

  belongs_to :user
  has_one_attached :image

  
  
end