class ObjsController < ApplicationController
  before_action :set_obj, only: [:show, :edit, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  respond_to :html

  def index
    @objs = @area.objs
  end

  def show

  end

  def new
    @obj = @area.objs.build

  end

  def edit
    
  end

  def create
    @obj = @area.objs.create(obj_params)
    if @obj.save
      redirect_to area_obj_path(@area, @obj), notice: 'Object was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @obj.update(obj_params)
      redirect_to area_Obj_path(@area, @obj), notice: 'Object was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @obj.destroy
    if @obj.save
      redirect_to area_objs_path(@area), notice: 'Object was sucessfully deleted.'
    else
      redirect_to area_objs_path(@area), notice: 'Something went wrong.'
    end
  end

  private
    def set_obj
      @obj = Obj.find(params[:id])
    end
    
    def set_area
        @area = Area.find(params[:area_id])
    end
    
    def obj_params
      params.require(:obj).permit(:area_id, :vnum, :keywords, :sdesc, :ldesc,
                                  :object_type, :v0, :v1, :v2, :v3, :extra_flags,
                                  :wear_flags, :weight, :cost, :misc_flags)
    end
end
