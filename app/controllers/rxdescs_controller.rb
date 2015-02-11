class RxdescsController < ApplicationController
  before_action :set_rxdesc, only: [:show, :edit, :update, :destroy]
  before_action :set_room, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]
  
  respond_to :html

  def index
    @rxdescs = @room.rxdescs
    respond_with(@rxdescs)
  end

  def show
    respond_with(@rxdesc)
  end

  def new
#    @rxdesc = Rxdesc.new
    @rxdesc = @room.rxdescs.build
    respond_with(@rxdesc)
  end

  def edit
  end

  def create
    @rxdesc = @room.rxdescs.create(rxdesc_params)
    if @rxdesc.save
      redirect_to area_room_path(@area, @room), notice: 'Room Extra Description was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @rxdesc.update(rxdesc_params)
      redirect_to area_room_rxdesc_path(@area, @room, @rxdesc), notice: 'Room Extra Description was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @rxdesc.destroy
    if @rxdesc.save
      redirect_to area_room_rxdescs_path(@area, @room), notice: 'Room was sucessfully deleted.'
    else
      redirect_to area_room_rxdescs_path(@area, @room), notice: 'Something went wrong.'
    end
  end

  private
    def set_rxdesc
      @rxdesc = Rxdesc.find(params[:id])
    end
    
    def set_room
      @room = Room.find(params[:room_id])
    end
    
    def set_area
      @area = Area.find(@room.area.id)
    end
    
    def rxdesc_params
      params.require(:rxdesc).permit(:keywords, :description, :room_id)
    end
end
