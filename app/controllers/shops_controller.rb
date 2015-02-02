class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :set_mobile, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  respond_to :html

  def index
    @shops = @mobile.shops
  end

  def show

  end

  def new
    @shop = @mobile.shops.build

  end

  def edit

  end

  def create
    @shop = @mobile.shops.create(shop_params)
    if @shop.save
      redirect_to area_mobile_path(@area, @mobile), notice: 'Shop was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @shop.update(shop_params)
      redirect_to area_mobile_path(@area, @mobile), notice: 'Shop was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @shop.destroy
    if @shop.save
      redirect_to area_mobile_path(@area, @mobile), notice: 'Shop was sucessfully deleted.'
    else
      redirect_to area_mobile_path(@area, @mobile), notice: 'Something went wrong.'
    end
  end

  private
    def set_shop
      @shop = Shop.find(params[:id])
    end
    
    def set_mobile
      @mobile = Mobile.find(params[:mobile_id])
    end
    
    def set_area
      @area = Area.find(@mobile.area.id)
    end
    
    def shop_params
      params.require(:shop).permit(:buy_type_1, :buy_type_2, :buy_type_3, :buy_type_4, :buy_type_5, :open_hour, :close_hour, :race, :mobile_id)
    end
end