class ExitsController < ApplicationController
  before_action :set_exit, only: [:show, :edit, :update, :destroy]
  before_action :set_room, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]
  
  respond_to :html

  def index
    @exits = @room.exits
    respond_with(@exits)
  end

  def show
    respond_with(@exit)
  end

  def new
    if params[:make_reciprocal]
      @new_room = @area.rooms.create(:vnum => @area.nextroomvnum,
                                     :name => '<room name here>',
                                     :description => '<room description here>',
                                     :terrain => @area.default_terrain,
                                     :room_flags => @area.default_room_flags
                                    )
      @this_exit = @room.exits.create(:exittype => 0,
                                      :keyvnum => 0,
                                      :exit_room_id => @new_room.id,
                                      :description => '',
                                      :name => '',
                                      :keywords => '',
                                      :direction => params[:dir]
                                     )
      @remote_exit = @new_room.exits.create(:exittype => 0,
                                            :keyvnum => 0,
                                            :exit_room_id => @room.id,
                                            :description => '',
                                            :name => '',
                                            :keywords => '',
                                            :direction => opposite_dir( params[:dir].to_i )
                                           )

      redirect_to area_room_path(@area, @room), notice: 'Reciprocal exit and new room created.'
    else
      @exit = @room.exits.build
  
      @exit.direction = params[:direction]
      @exit.description = params[:description]
      @exit.keywords = params[:keywords]
      @exit.exittype = params[:exittype]
      @exit.keyvnum = params[:keyvnum]
      @exit.exit_room_id = params[:exit_room_id]
      @exit.name = params[:name]
      
      @exit.exittype ||= 0
      @exit.keyvnum ||= 0
      @exit.exit_room_id ||= -1
    end #if make_reciprocal
  end

  def edit
  end

  def create
    if not params[:exit]
      @exit = @room.exits.build
      @exit.direction = params[:direction]
      @exit.description = params[:description]
      @exit.keywords = params[:keywords]
      @exit.exittype = params[:exittype]
      @exit.keyvnum = params[:keyvnum]
      @exit.exit_room_id = params[:exit_room_id]
      @exit.name = params[:name]
    else
      @exit = @room.exits.create(exit_params)
    end
    if @exit.save
      redirect_to area_room_path(@area, @room), notice: 'Room Exit was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @exit.update(exit_params)
      redirect_to area_room_path(@area, @room), notice: 'Room Exit was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @exit.destroy
    if @exit.save
      redirect_to area_room_path(@area, @room), notice: 'Room was sucessfully deleted.'
    else
      redirect_to area_room_path(@area, @room), notice: 'Something went wrong.'
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
      @area = Area.find(params[:area_id])
    end
    
    def exit_params
      params.require(:exit).permit(:direction, :description, :keywords, :exittype, :keyvnum, :exit_room_id, :name, :reset, :room_id)
    end
end
