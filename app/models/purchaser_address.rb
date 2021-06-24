class PurchaserAddress
  include ActiveModel::Model
  attr_accessor :post_code, :ship_from_id, :city, :street, :building, :phone, :price, :item_id, :user_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A\d{3}[-]\d{4}\z/}
    validates :ship_from_id
    validates :city
    validates :street
    validates :phone, format: { with: /\A\d{10,11}\z/}
    validates :item_id
    validates :user_id
  end

  def save
    purchaser = Purchaser.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, ship_from_id: ship_from_id, city: city, street: street, building: building, phone: phone, purchaser_id: purchaser.id)
  end
end