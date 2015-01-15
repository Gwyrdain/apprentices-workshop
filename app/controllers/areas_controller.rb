class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!#, except: [:index]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
#   For now, show all... later show only the user's areas.
    @areas = Area.all
#    @areas = Area.where(user_id: current_user.id)
#    respond_with(@areas)
  end

  def show
#    respond_with(@area)
  end

  def new
    @area = current_user.areas.build
#    respond_with(@area)
  end

  def edit
  end

  def create
    @area = current_user.areas.build(area_params)
    if @area.save
      redirect_to @area, notice: 'Area was sucessfully created.'
    else
      render action: 'new'
    end
#    respond_with(@area)
  end

  def update
    if @area.update(area_params)
      redirect_to @area, notice: 'Area was sucessfully updated.'
    else
      render action: 'edit'
    end     
#    respond_with(@area)
  end

  def destroy
    @area.destroy
    redirect_to areas_url
#    respond_with(@area)
  end

  private
    def set_area
      @area = Area.find(params[:id])
    end

    def area_params
      params.require(:area).permit(:name, :author, :difficulty)
    end
end


def correct_user
    @area = current_user.areas.find_by(id: params[:id])
    redirect_to areas_path, notice: "Not authorized to edit this area" if @area.nil?
    
end