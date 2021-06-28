class PurchaserAddress
  include ActiveModel::Model
  attr_accessor :post_code, :ship_from_id, :city, :street, :building, :phone, :price, :item_id, :user_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'は - を含む半角文字列を使用してください'}
    validates :ship_from_id, numericality: { other_than: 1, message: 'を選んでください'}
    validates :city
    validates :street
    validates :phone, format: { with: /\A\d{10,11}\z/, message: 'は10桁以上11桁以内の半角数値のみを使用してください'}
    validates :item_id
    validates :user_id
    validates :token
  end

  def save
    purchaser = Purchaser.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, ship_from_id: ship_from_id, city: city, street: street, building: building, phone: phone, purchaser_id: purchaser.id)
  end
end