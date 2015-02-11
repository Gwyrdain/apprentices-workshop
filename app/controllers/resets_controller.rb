class ResetsController < ApplicationController
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_reset, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @resets = @area.resets
  end

  def show

  end

  def new
      @reset = @area.resets.build
      
      @reset.reset_type = params[:reset_type]

  end

  def edit
    
  end

  def create
    if not params[:reset]
      @reset = @area.resets.build
    end
    
    @reset = @area.resets.create(reset_params)
    
    if @reset.save
      redirect_to area_reset_path(@area, @reset), notice: 'Reset was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @reset.update(reset_params)
      redirect_to area_reset_path(@area, @reset), notice: 'Reset was sucessfully updated.'
    else
      render action: 'edit'
    end    
  end

  def destroy
    @reset.destroy
    if @reset.save
      redirect_to area_resets_path(@area), notice: 'Reset was sucessfully deleted.'
    else
      redirect_to area_resets_path(@area), notice: 'Something went wrong.'
    end
  end

  private
    def set_reset
      @reset = Reset.find(params[:id])
    end
    
    def set_area
        @area = Area.find(params[:area_id])
    end

    def reset_params
      params.require(:reset).permit(:reset_type, :val_1, :val_2, :val_3, :val_4, :area_id)
    end
end
