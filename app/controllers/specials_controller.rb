class SpecialsController < ApplicationController
  before_action :authenticate_user!#, except: [:index]
  before_action :set_special, only: [:show, :edit, :update, :destroy]
  before_action :set_mobile, only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @specials = @area.specials
  end

  def show

  end

  def new
    @special = @mobile.specials.build
    
    @special.extended_value_1 ||= -1
    @special.extended_value_2 ||= -1
    @special.extended_value_3 ||= -1
    @special.extended_value_4 ||= -1
    @special.extended_value_5 ||= -1
    
  end

  def edit

  end

  def create
    @special = @mobile.specials.create(special_params)
    
    @special.extended_value_1 ||= -1
    @special.extended_value_2 ||= -1
    @special.extended_value_3 ||= -1
    @special.extended_value_4 ||= -1
    @special.extended_value_5 ||= -1

    if @special.save
      redirect_to area_mobile_path(@area, @mobile), notice: 'Special Function was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @special.update(special_params)
      redirect_to area_mobile_path(@area, @mobile), notice: 'Special Function was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @special.destroy
    if @special.save
      redirect_to area_mobile_path(@area, @mobile), notice: 'Special Function was sucessfully deleted.'
    else
      redirect_to area_mobile_path(@area, @mobile), notice: 'Something went wrong.'
    end
  end

  private
    def set_special
      @special = Special.find(params[:id])
    end
    
    def set_mobile
      @mobile = Mobile.find(params[:mobile_id])
    end
    
    def set_area
      @area = Area.find(params[:area_id])
    end
    
    def special_params
      params.require(:special).permit(:special_type, :name, :extended_value_1, :extended_value_2, :extended_value_3, :extended_value_4, :extended_value_5, :mobile_id)
    end
end
