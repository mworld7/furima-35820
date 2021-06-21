class PurchasersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
   
  end

  def create
    @purchaser = Purchaser.create(purchaser_params)
    Address.create(address_params)
    redirect_to root_path
  end

end
