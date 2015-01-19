class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!#, except: [:index]
#  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
#   For now, show all... later show only the user's areas.
    @areas = Area.all
#    @areas = Area.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @area = current_user.areas.build
  end

  def edit
  end

  def create
    @area = current_user.areas.create(area_params)
    if @area.save
      redirect_to @area, notice: 'Area was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @area.update(area_params)
      redirect_to @area, notice: 'Area was sucessfully updated.'
    else
      render action: 'edit'
    end     
  end

  def destroy
    @area.destroy
    redirect_to areas_url
  end

  private
    def set_area
      @area = Area.find(params[:id])
    end

    def area_params
      params.require(:area).permit(:name, :author, :difficulty, :area_number,
                                   :vnum_qty, :manmade, :city, :forest,
                                   :limited, :aerial, :reserved, :arena,
                                   :quest, :novnum
                                  )
    end
end


def correct_user
    @area = current_user.areas.find_by(id: params[:id])
    redirect_to areas_path, notice: "Not authorized to edit this area" if @area.nil?
    
end