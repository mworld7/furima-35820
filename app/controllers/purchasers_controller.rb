class PurchasersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    @purchaser_address = PurchaserAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    binding.pry
    @purchaser_address = PurchaserAddress.new(purchaser_params)
    if @purchaser_address.valid?
      @purchaser_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchaser_params
    params.require(:purchaser_address).permit(:post_code, :ship_from_id, :city, :street, :building, :phone, :price, :item_id).merge(user_id: current_user.id)
  end

end