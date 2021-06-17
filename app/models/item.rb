class Item < ApplicationRecord
  vakidates :title, presence: true
  validates :price, presence: true
  validates :description, presence: true
  # validates :category_id, presence: true
  # validates :condition_id, presence: true
  # validates :postage_by_id, presence: true
  # validates :ship_from_id, presence: true
  # validates :shipping_date_id, presence: true
  validates :genre_id, numericality: { other_than: 1 } 

  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage_by
  belongs_to :ship_from
  belongs_to :shipping_date
  
end