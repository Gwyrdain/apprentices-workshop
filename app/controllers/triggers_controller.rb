class TriggersController < ApplicationController
  before_action :set_trigger, only: [:show, :edit, :update, :destroy]
  before_action :set_exit, only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :set_room, only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy] #[:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @triggers = @area.triggers
  end

  def show

  end

  def new
    @trigger = @exit.triggers.build
    
    @trigger.extended_value_1 ||= -1
    @trigger.extended_value_2 ||= -1
    @trigger.extended_value_3 ||= -1
    @trigger.extended_value_4 ||= -1
    @trigger.extended_value_5 ||= -1
  end

  def edit

  end

  def create
    @trigger = @exit.triggers.create(trigger_params)
    
    @trigger.extended_value_1 ||= -1
    @trigger.extended_value_2 ||= -1
    @trigger.extended_value_3 ||= -1
    @trigger.extended_value_4 ||= -1
    @trigger.extended_value_5 ||= -1
    
    if @trigger.save
      redirect_to area_room_path(@area, @room), notice: 'Exit Trigger was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @trigger.update(trigger_params)
      redirect_to area_room_path(@area, @room), notice: 'Exit Trigger was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @trigger.destroy
    if @trigger.save
      redirect_to area_room_path(@area, @room), notice: 'Exit Trigger was sucessfully deleted.'
    else
      redirect_to area_room_path(@area, @room), notice: 'Something went wrong.'
    end
  end

  private
    def set_trigger
      @trigger = Trigger.find(params[:id])
    end
    
    def set_exit
      @exit = Exit.find(params[:exit_id])
    end
    
    def set_room
      @room = Room.find(params[:room_id])
    end
    
    def set_area
      @area = Area.find(params[:area_id])
    end
    
    def trigger_params
      params.require(:trigger).permit(:trigger_type, :name, :extended_value_1,
                                      :extended_value_2, :extended_value_3,
                                      :extended_value_4, :extended_value_5,
                                      :exit_id
                                     )
    end
end
