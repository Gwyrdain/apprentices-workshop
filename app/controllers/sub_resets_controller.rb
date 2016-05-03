class SubResetsController < ApplicationController
  before_action :authenticate_user!#, except: [:index]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_reset, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_sub_reset, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @sub_resets = @reset.sub_resets
  end

  def show

  end

  def new
      @sub_reset = @reset.sub_resets.build
      
      @sub_reset.reset_type = params[:reset_type]
      @sub_reset.val_3 ||= 100

  end

  def edit
    
  end

  def create
    if not params[:sub_reset]
      @sub_reset = @reset.sub_resets.build
    end
    
    @sub_reset = @reset.sub_resets.create(sub_reset_params)

    if @sub_reset.save
      @area.update(:last_updated_at => Time.now, :last_updated_by => current_user.id)
      if params[:return_to_room]
        redirect_to area_room_path(@area, params[:return_to_room]), notice: 'Sub-reset was sucessfully created.'
      else
        redirect_to area_reset_path(@area, @reset), notice: 'Sub-reset was sucessfully created.'
      end
    else
      render action: 'new'
    end
  end

  def update
    if @sub_reset.update(sub_reset_params)
      @area.update(:last_updated_at => Time.now, :last_updated_by => current_user.id)
      if params[:return_to_room]
        redirect_to area_room_path(@area, params[:return_to_room]), notice: 'Sub-reset was sucessfully created.'
      else
        redirect_to area_reset_path(@area, @reset), notice: 'Sub-reset was sucessfully updated.'
      end
    else
      render action: 'edit'
    end    
  end

  def destroy
    @sub_reset.destroy
    if @sub_reset.save
      @area.update(:last_updated_at => Time.now, :last_updated_by => current_user.id)
      redirect_to area_reset_path(@area, @reset), notice: 'Sub-reset was sucessfully deleted.'
    else
      redirect_to area_reset_path(@area, @reset), notice: 'Something went wrong.'
    end
  end

  private
    def set_sub_reset
      @sub_reset = SubReset.find(params[:id])
    end

    def set_reset
        @reset = Reset.find(params[:reset_id])
    end

    def set_area
        @area = Area.find(params[:area_id])
    end

    def sub_reset_params
      params.require(:sub_reset).permit(:reset_type, :val_1, :val_2, :val_3, :val_4, :reset_id)
    end
end
