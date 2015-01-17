class ExitsController < ApplicationController
  before_action :set_exit, only: [:show, :edit, :update, :destroy]
  before_action :set_room, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  
  respond_to :html

  def index
    @exits = @room.exits
    respond_with(@exits)
  end

  def show
    respond_with(@exit)
  end

  def new
#    @exit = Exit.new
    @exit = @room.exits.build
    respond_with(@exit)
  end

  def edit
  end

  def create
    @exit = @room.exits.create(exit_params)
    if @exit.save
      redirect_to area_room_exit_path(@area, @room, @exit), notice: 'Room Exit was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @exit.update(exit_params)
      redirect_to area_room_exit_path(@area, @room, @exit), notice: 'Room Exit was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @exit.destroy
    if @exit.save
      redirect_to area_room_exits_path(@area, @room), notice: 'Room was sucessfully deleted.'
    else
      redirect_to area_room_exits_path(@area, @room), notice: 'Something went wrong.'
    end
  end

  private
    def set_exit
      @exit = Exit.find(params[:id])
    end
    
    def set_room
      @room = Room.find(params[:room_id])
    end
    
    def set_area
      @area = Area.find(@room.area.id)
    end
    
    def exit_params
      params.require(:exit).permit(:direction, :description, :keywords, :exittype, :keyvnum, :exitto, :name, :room_id)
    end
end
