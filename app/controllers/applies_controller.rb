class AppliesController < ApplicationController
  before_action :authenticate_user!#, except: [:index]
  before_action :set_apply, only: [:show, :edit, :update, :destroy]
  before_action :set_obj, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]
  
  respond_to :html

  def index
    @applies = @obj.applies
    respond_with(@applies)
  end

  def show
    respond_with(@apply)
  end

  def new
#    @apply = Apply.new
    @apply = @obj.applies.build
    respond_with(@apply)
  end

  def edit
  end

  def create
    @apply = @obj.applies.create(apply_params)
    if @apply.save
      Obj.update(@apply.obj_id, :magic => true)
      redirect_to area_obj_path(@area, @obj), notice: 'Apply was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @apply.update(apply_params)
      Obj.update(@apply.obj_id, :magic => true)
      redirect_to area_obj_path(@area, @obj), notice: 'Apply was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @apply.destroy
    if @apply.save
      redirect_to area_obj_path(@area, @obj), notice: 'Apply was sucessfully deleted.'
    else
      redirect_to area_obj_path(@area, @obj), notice: 'Something went wrong.'
    end
  end

  private
    def set_apply
      @apply = Apply.find(params[:id])
    end
    
    def set_obj
      @obj = Obj.find(params[:obj_id])
    end
    
    def set_area
      @area = Area.find(@obj.area.id)
    end
    
    def apply_params
      params.require(:apply).permit(:apply_type, :amount, :obj_id)
    end
end
