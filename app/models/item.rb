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

# class Category < ActiveHash::Base
#   self.data = [
#     { id: 1, name: '---' },
#     { id: 2, name: 'メンズ' },
#     { id: 3, name: 'レディース'},
    # { id: 4, name: 'ベビー・キッズ' },
#     { id: 5, name: 'インテリア・住まい・小物' },
#     { id: 6, name: '本・音楽・ゲーム' },
#     { id: 7, name: 'おもちゃ・ホビー・グッズ' },
#     { id: 8, name: '家電・スマホ・カメラ' },
#     { id: 9, name: 'スポーツ・レジャー' },
#     { id: 10, name: 'ハンドメイド' }
#     { id: 11, name: 'その他' }
#   ]
#   end