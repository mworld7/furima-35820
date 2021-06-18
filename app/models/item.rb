class Item < ApplicationRecord
  with_options presence: true do 
    vakidates :title, presence: true
    validates :description, presence: true
    validates :category_id, presence: true
    validates :condition_id, presence: true
    validates :postage_by_id, presence: true
    validates :ship_from_id, presence: true
    validates :shipping_date_id, presence: true
  end
  validates :price, presence: true, numericality: {in:300..9999999}, format: { with: /\A[0-9]+\z/ } #"presence: true" と "numericality:"は意味が重複する？ 
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