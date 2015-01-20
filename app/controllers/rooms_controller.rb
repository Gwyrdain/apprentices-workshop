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
#      @room.vnum ||= @area.nextroomvnum
      #if params[:vnum]
      #end
      
      @room.vnum = params[:vnum]
      @room.name = params[:name]
      @room.description = params[:description]
      @room.terrain = params[:terrain]
      @room.room_flags = params[:room_flags]
      
      @room.vnum ||= @area.nextroomvnum
      @room.terrain ||= @area.default_terrain
      @room.room_flags ||= @area.default_room_flags
      
  end

  def edit
    
  end

  def create
    if not params[:room]
      @room = @area.rooms.build
    end
    
    @room = @area.rooms.create(room_params)
    
    if @room.save
      redirect_to area_room_path(@area, @room), notice: 'Room was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @room.update(room_params)
      redirect_to area_room_path(@area, @room), notice: 'Room was sucessfully updated.'
    else
      render action: 'edit'
    end    
  end

  def destroy
    @room.destroy
    Exit.where(:exit_room_id => @room.id).delete_all
    if @room.save
      redirect_to area_rooms_path(@area), notice: 'Room and all associated exits to this room were sucessfully deleted.'
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
      params.require(:room).permit(:vnum, :name, :description, :terrain,
                                   :area_id, :dark, :no_sleep, :no_mob,
                                   :indoors, :foggy, :private_room, :peaceful,
                                   :solitary, :no_recall, :no_steal, :notrans,
                                   :no_spell, :no_fly, :fly_ok, :no_quest,
                                   :no_item, :no_vnum, :room_flags
                                  )
    end
    
end
