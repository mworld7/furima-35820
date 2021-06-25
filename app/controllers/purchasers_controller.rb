class PurchasersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @purchaser_address = PurchaserAddress.new
  end

  def create
    @purchaser_address = PurchaserAddress.new(purchaser_params)
    if @purchaser_address.valid?
      pay_item
      @purchaser_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchaser_params
    params.require(:purchaser_address).permit(:post_code, :ship_from_id, :city, :street, :building, :phone, :price).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(amount: @item.price, card: purchaser_params[:token], currency: 'jpy')
  end

  def move_to_index
    redirect_to root_path if @item.purchaser.present? || current_user == @item.user
  end

end