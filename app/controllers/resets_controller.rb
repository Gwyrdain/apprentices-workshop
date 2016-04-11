class ResetsController < ApplicationController
  before_action :authenticate_user!#, except: [:index]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_reset, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @resets = @area.resets
  end

  def show

  end

  def new
    if params[:copy_reset]
      base_reset = Reset.find(params[:copy_reset])
      new_reset = base_reset.dup
      new_reset.save
      
      base_reset.sub_resets.each do |sub_reset|
        new_sub_reset = sub_reset.dup
        new_sub_reset.reset_id = new_reset.id
        new_sub_reset.save
      end
      
      redirect_to area_resets_path(@area), notice: 'Reset copied.'
    else
      @reset = @area.resets.build
      @reset.reset_type = params[:reset_type]
    end
  end

  def edit
    
  end

  def create
    new_record = false
    
    if not params[:reset]
      @reset = @area.resets.build
    end
    
    if params[:reset][:val_2].to_i == 0 # Calling for a New
      new_record = true
      if params[:reset][:reset_type] == 'O'
        $record = @area.objs.create(:vnum => @area.nextobjvnum,
                                    :sdesc => '<sdesc here>',
                                    :ldesc => '<ldesc here>',
                                    :keywords => '<keywords here>',
                                    :object_type => 1,
                                    :v0 => 0,
                                    :v1 => 0,
                                    :v2 => 0,
                                    :v3 => 0,
                                    :extra_flags => 0,
                                    :wear_flags => 1,
                                    :misc_flags => 0,
                                    :weight => 1,
                                    :cost => 0
                                    )
      end
      if params[:reset][:reset_type] == 'M'
        $record = @area.mobiles.create( :vnum => @area.nextmobilevnum,
                                        :sdesc => '<sdesc here>',
                                        :ldesc => '<ldesc here>',
                                        :look_desc => '<look desc here>',
                                        :keywords => '<keywords here>',
                                        :act_flags => 64,
                                        :affect_flags => 0,
                                        :alignment => 0,
                                        :level => 1,
                                        :sex => 0,
                                        :langs_known => 0,
                                        :lang_spoken => 0
                                        )
      end
    end
    
    @reset = @area.resets.create(reset_params)
    
    if new_record
      @reset.update(:val_2 => $record.id)
    end    
    
    if @reset.save
      if params[:return_to_room]
        redirect_to area_room_path(@area, params[:return_to_room]), notice: 'Reset was sucessfully created.'
      else
        redirect_to area_reset_path(@area, @reset), notice: 'Reset was sucessfully created.'
      end
    else
      render action: 'new'
    end
  end

  def update
    if @reset.update(reset_params)
      if params[:return_to_room]
        redirect_to area_room_path(@area, params[:return_to_room]), notice: 'Reset was sucessfully updated.'
      else
        redirect_to area_reset_path(@area, @reset), notice: 'Reset was sucessfully updated.'
      end
    else
      render action: 'edit'
    end    
  end

  def destroy
    Reset.where(parent_id: @reset.id).destroy_all
    @reset.destroy
    if @reset.save
      if params[:return_to_room]
        redirect_to area_room_path(@area, params[:return_to_room]), notice: 'Reset was sucessfully deleted.'
      else
        redirect_to area_resets_path(@area), notice: 'Reset was sucessfully deleted.'
      end
    else
      redirect_to area_resets_path(@area), notice: 'Something went wrong.'
    end
  end

  private
    def set_reset
      @reset = Reset.find(params[:id])
    end
    
    def set_area
        @area = Area.find(params[:area_id])
    end

    def reset_params
      params.require(:reset).permit(:reset_type, :parent_type, :parent_id,
                                    :val_1, :val_2, :val_3, :val_4, :area_id)
    end
end
