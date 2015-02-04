class RoomSpecialsController < ApplicationController
  before_action :set_room_special, only: [:show, :edit, :update, :destroy]
  before_action :set_room, only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  respond_to :html

  def index
    @room_specials = @area.room_specials
  end

  def show

  end

  def new
    @room_special = @room.room_specials.build

  end

  def edit

  end

  def create
    @room_special = @room.room_specials.create(room_special_params)
    if @room_special.save
      redirect_to area_room_path(@area, @room), notice: 'Room Special Function was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @room_special.update(room_special_params)
      redirect_to area_room_path(@area, @room), notice: 'Room Special Function was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @room_special.destroy
    if @room_special.save
      redirect_to area_room_path(@area, @room), notice: 'Room Special Function was sucessfully deleted.'
    else
      redirect_to area_room_path(@area, @room), notice: 'Something went wrong.'
    end
  end

  private
    def set_room_special
      @room_special = RoomSpecial.find(params[:id])
    end
    
    def set_room
      @room = Room.find(params[:room_id])
    end
    
    def set_area
      @area = Area.find(params[:area_id])
    end
    
    def room_special_params
      params.require(:room_special).permit(:room_special_type, :name, :extended_value_1, :extended_value_2, :extended_value_3, :extended_value_4, :extended_value_5, :room_id)
    end
end
