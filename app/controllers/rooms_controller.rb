class RoomsController < ApplicationController
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @rooms = @area.rooms
  end

  def show

  end

  def new
        @room = @area.rooms.build
  end

  def edit
    
  end

  def create
    @room = @area.rooms.create(room_params)
    redirect_to area_rooms_path(@area)
  end

  def update
    #render text: params.inspect
    if @room.update(room_params)
      redirect_to area_room_path(@area, @room), notice: 'Room was sucessfully updated.'
    else
      render action: 'edit'
    end    
  end

  def destroy
    @room.destroy
    if @room.save
      redirect_to area_rooms_path(@area), notice: 'Room was sucessfully deleted.'
    else
      redirect_to area_rooms_path(@area), notice: 'Something went wrong.'
    end
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end
    
    def set_area
        @area = Area.find(params[:area_id])
    end

    def room_params
      params.require(:room).permit(:vnum, :name, :description, :terrain, :area_id,
                                   :dark, :no_sleep, :no_mob, :indoors, :foggy, 
                                   :private_room, :peaceful, :solitary, :no_recall,
                                   :no_steal, :notrans, :no_spell, :no_fly, :fly_ok,
                                   :no_quest, :no_item, :no_vnum
                                  )
    end
end
