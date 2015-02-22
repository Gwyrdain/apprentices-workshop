class OxdescsController < ApplicationController
  before_action :authenticate_user!#, except: [:index]
  before_action :set_oxdesc, only: [:show, :edit, :update, :destroy]
  before_action :set_obj, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]
  
  respond_to :html

  def index
    @oxdescs = @obj.oxdescs
    respond_with(@oxdescs)
  end

  def show
    respond_with(@oxdesc)
  end

  def new
#    @oxdesc = Oxdesc.new
    @oxdesc = @obj.oxdescs.build
    respond_with(@oxdesc)
  end

  def edit
  end

  def create
    @oxdesc = @obj.oxdescs.create(oxdesc_params)
    if @oxdesc.save
      redirect_to area_obj_path(@area, @obj), notice: 'Obj Extra Description was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @oxdesc.update(oxdesc_params)
      redirect_to area_obj_oxdesc_path(@area, @obj, @oxdesc), notice: 'Obj Extra Description was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @oxdesc.destroy
    if @oxdesc.save
      redirect_to area_obj_oxdescs_path(@area, @obj), notice: 'Obj was sucessfully deleted.'
    else
      redirect_to area_obj_oxdescs_path(@area, @obj), notice: 'Something went wrong.'
    end
  end

  private
    def set_oxdesc
      @oxdesc = Oxdesc.find(params[:id])
    end
    
    def set_obj
      @obj = Obj.find(params[:obj_id])
    end
    
    def set_area
      @area = Area.find(params[:area_id])
    end
    
    def oxdesc_params
      params.require(:oxdesc).permit(:keywords, :description, :obj_id)
    end
end
