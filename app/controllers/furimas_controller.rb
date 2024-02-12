class FurimasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
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

end
