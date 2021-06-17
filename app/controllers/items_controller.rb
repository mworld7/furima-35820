class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Items.new
  end

  def create
    Item.create(item_params)
  end

  private
    params.require(:item).permit(:title, :price, :image, :description, :category_id, :condition_id, :postage_by_id, :ship_from_id, :shipping_date_id).merge(user_id: current_user.id)
  end

end
