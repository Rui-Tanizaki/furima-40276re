class FurimasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:update, :edit, :show, :destroy]
  before_action :set_user_item, only: [:show, :edit]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id if current_user
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if @user_item && @user_item.item.present?
      redirect_to root_path
    elsif current_user != @item.user
      redirect_to root_path
    end

  end

  def update
    if @item.update(item_params)
      redirect_to furima_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    if current_user != @item.user
      redirect_to root_path
    else
      @item.destroy
      redirect_to root_path
    end
  end

  private

  def set_user_item
    @user_item = UserItem.find_by(item_id: @item.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :item_name, :item_info, :item_price, :item_category_id, :item_sales_status_id,
                                 :item_shipping_fee_status_id, :prefecture_id, :item_scheduled_delivery_id)
  end

end
