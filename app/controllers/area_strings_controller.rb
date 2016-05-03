class AreaStringsController < ApplicationController
  before_action :authenticate_user!#, except: [:index]
  before_action :set_area_string, only: [:show, :edit, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @area_strings = @area.area_strings
  end

  def show

  end

  def new
    @area_string = @area.area_strings.build

    @area_string.vnum = @area.nextarea_stringvnum
    @area_string.message_to_pc ||= ''
    @area_string.message_to_room ||= ''
  end

  def edit
    
  end

  def create
    @area_string = @area.area_strings.create(area_string_params)
    @area_string.message_to_pc ||= ''
    @area_string.message_to_room ||= ''
    
    if @area_string.save
      @area.update(:last_updated_at => Time.now, :last_updated_by => current_user.id)
      redirect_to area_area_string_path(@area, @area_string), notice: 'String was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @area_string.update(area_string_params)
      @area.update(:last_updated_at => Time.now, :last_updated_by => current_user.id)
      redirect_to area_area_string_path(@area, @area_string), notice: 'String was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @area_string.destroy
    if @area_string.save
      @area.update(:last_updated_at => Time.now, :last_updated_by => current_user.id)
      redirect_to area_area_strings_path(@area), notice: 'String was sucessfully deleted.'
    else
      redirect_to area_area_strings_path(@area), notice: 'Something went wrong.'
    end
  end

  private
    def set_area_string
      @area_string = AreaString.find(params[:id])
    end
    
    def set_area
        @area = Area.find(params[:area_id])
    end

    def area_string_params
      params.require(:area_string).permit(:vnum, :message_to_pc, :message_to_room, :area_id)
    end
end
