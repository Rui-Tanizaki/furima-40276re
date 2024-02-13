class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item,only:[:index]

  def index
    @user_item = UserItem.find_by(item_id: @item.id)
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item_order = ItemOrder.new
    
    if @user_item && @user_item.item.present?
       redirect_to root_path
    elsif current_user == @item.user
       redirect_to root_path
    end

  end

  def create
    @item_order = ItemOrder.new(item_order_params)
    if @item_order.valid?
      pay_item
      @item_order.save
      return redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      set_item
      render :index, status: :unprocessable_entity
    end
  end

  private

  def pay_item
    set_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.item_price,
      card: @item_order.token,
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:furima_id])
  end

  def user_item_params
    params.permit(:user_id, :item_id)
  end

  def item_order_params
    params.require(:item_order).permit(
      :order_postcode, :prefecture_id, :order_city, :order_address, :order_building, :order_phone_number
    ).merge(user_id: current_user.id, item_id: params[:furima_id], token: params[:token])
  end
  
end
