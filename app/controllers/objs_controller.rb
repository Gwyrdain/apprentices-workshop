class ObjsController < ApplicationController
  before_action :authenticate_user!#, except: [:index]
  before_action :set_obj, only: [:show, :edit, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy, :edit_multiple]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @objs = @area.objs

    if params[:purge]
      @area.objs.where(:sdesc => '<sdesc here>').each do |obj|
        obj.destroy
      end
      redirect_to area_objs_path(@area), notice: 'Purged unedited objects.'
    end
  end

  def show

  end

  def new
    if params[:copy_obj] # Copying on object
      base_obj = Obj.find(params[:copy_obj])
      new_obj = base_obj.dup
      new_obj.vnum = @area.nextobjvnum
      new_obj.save

      base_obj.oxdescs.each do |oxdesc|
        new_oxdesc = oxdesc.dup
        new_oxdesc.obj_id = new_obj.id
        new_oxdesc.save
      end

      base_obj.applies.each do |apply|
        new_apply = apply.dup
        new_apply.obj_id = new_obj.id
        new_apply.save
      end

      redirect_to area_objs_path(@area),
                  notice: new_obj.errors.any? ? 'Error: ' + new_obj.errors.full_messages[0].to_s : 'Object copied.'
    else
      if params[:make]
        params[:make].to_i.times do
          @area.objs.create(:vnum => @area.nextobjvnum,
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
        redirect_to area_objs_path(@area), notice: 'Empty objects created.'
      else
        @obj = @area.objs.build

        @obj.vnum = @area.nextobjvnum
        @obj.v0 = 0
        @obj.v1 = 0
        @obj.v2 = 0
        @obj.v3 = 0
        @obj.extra_flags = 0
        @obj.wear_flags = 1
        @obj.misc_flags = 0
        @obj.weight = 1
        @obj.cost = 0
      end
    end
  end

  def edit

  end

  def create
    @obj = @area.objs.create(obj_params)
    @obj.misc_flags ||= 0
    @obj.extra_flags ||= 0
    @obj.wear_flags ||= 0

    if @obj.save
      @area.update(:last_updated_at => Time.now, :last_updated_by => current_user.id)
      redirect_to area_obj_path(@area, @obj), notice: 'Object was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @obj.update(obj_params)

      if params[:return_to_room]
        @area.update(:last_updated_at => Time.now, :last_updated_by => current_user.id)
        redirect_to area_room_path(@area, params[:return_to_room]), notice: 'Object was sucessfully updated.'
      else
        redirect_to area_obj_path(@area, @obj), notice: 'Object was sucessfully updated.'
      end
    else
      render action: 'edit'
    end
  end

  def destroy
    @obj.destroy
    if @obj.save
      @area.update(:last_updated_at => Time.now, :last_updated_by => current_user.id)
      redirect_to area_objs_path(@area), notice: 'Object was sucessfully deleted.'
    else
      redirect_to area_objs_path(@area), notice: 'Something went wrong.'
    end
  end

  def edit_multiple

    if params[:obj_ids]

      @objs = Obj.find(params[:obj_ids])

      if params[:commit] == "Delete Selected"
        @objs.each do |obj|
          obj.destroy
        end
        redirect_to area_objs_path(@area), notice: 'Deleted multiple objects.'
      end
      if params[:commit] == "Update Objects"
        @objs.reject! do |obj|
          obj.update_attributes(obj_params.reject { |k,v| v.blank? })
        end
        if @objs.empty?
          redirect_to area_objs_path(@area), notice: 'Updated multiple objects.'
        else
          render "edit_multiple"
        end
      end
    else
      redirect_to area_objs_path(@area), notice: 'No objects selected.'
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
                                  :wear_flags, :weight, :cost, :misc_flags,
                                  :takeable, :finger, :neck, :body, :head, :legs,
                                  :feet, :hands, :arms, :shield, :about, :waist,
                                  :wrist, :hold, :decoration,
                                  :glow, :hum, :evil, :invis, :magic, :nodrop,
                                  :anti_good, :anti_evil, :anti_neutral,
                                  :noremove, :inventory, :metallic, :good,
                                  :not_purgable, :flammable, :two_handed,
                                  :use_cost, :anti_unalign, :neutral, :no_hoard,
                                  :masked,
                                  :underwater_breath
                                  )
    end
end
