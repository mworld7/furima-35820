class Item < ApplicationRecord
  belongs_to :user
  has_one :purchaser
  has_many_attached :images
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage_by
  belongs_to :ship_from
  belongs_to :shipping_date

  with_options presence: true do
    validates :title
    validates :description
    validates :images

    with_options numericality: { other_than: 1, message: 'を選んでください' } do
      validates :category_id
      validates :condition_id
      validates :postage_by_id
      validates :ship_from_id
      validates :shipping_date_id
    end

    with_options numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                 format: { with: /\A[0-9]+\z/ } do
      validates :price
    end
  end
end
