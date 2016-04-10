class MobilesController < ApplicationController
  before_action :authenticate_user!#, except: [:index]
  before_action :set_mobile, only: [:show, :edit, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy, :edit_multiple]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @mobiles = @area.mobiles
    
    if params[:purge]
      @area.mobiles.where(:sdesc => '<sdesc here>').each do |mobile|
        mobile.destroy
      end
      redirect_to area_mobiles_path(@area), notice: 'Purged unedited mobiles.'
    end
  end

  def show
    
  end

  def new
    
    if params[:copy_mobile] # Copying a mobile
      base_mobile = Mobile.find(params[:copy_mobile])
      new_mobile = base_mobile.dup
      new_mobile.vnum = @area.nextmobilevnum
      new_mobile.save
      
      base_mobile.specials.each do |special|
        new_special = special.dup
        new_special.mobile_id = new_mobile.id
        new_special.save
      end

      base_mobile.shops.each do |shop|
        new_shop = shop.dup
        new_shop.mobile_id = new_mobile.id
        new_shop.save
      end
      
      redirect_to area_mobiles_path(@area), 
                  notice: new_mobile.errors.any? ? 'Error: ' + new_mobile.errors.full_messages[0].to_s : 'Mobile copied.'
    else
      
      if params[:make] # Pre-make multiple mobiles.
        params[:make].to_i.times do
          @area.mobiles.create( :vnum => @area.nextmobilevnum,
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
        redirect_to area_mobiles_path(@area), notice: 'Empty mobiles created.'
      else
        @mobile = @area.mobiles.build
    
        @mobile.vnum = @area.nextmobilevnum
        @mobile.act_flags = 64
        @mobile.affect_flags = 0
        @mobile.alignment = 0
        @mobile.level = 1
        @mobile.sex = 0
        @mobile.langs_known = 0
        @mobile.lang_spoken = 0
      end
    end
  end

  def edit
    
  end

  def create
    @mobile = @area.mobiles.create(mobile_params)
    @mobile.act_flags ||= 64
    @mobile.affect_flags ||= 0
    @mobile.alignment ||= 0
    @mobile.level ||= 1
    @mobile.sex ||= 0
    @mobile.langs_known ||= 0
    @mobile.lang_spoken ||= 0
    
    if @mobile.save
      redirect_to area_mobile_path(@area, @mobile), notice: 'Mobile was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @mobile.update(mobile_params)
      if params[:return_to_room]
        redirect_to area_room_path(@area, params[:return_to_room]), notice: 'Mobile was sucessfully updated.'
      else
        redirect_to area_mobile_path(@area, @mobile), notice: 'Mobile was sucessfully updated.'
      end
    else
      render action: 'edit'
    end 
  end

  def destroy
    @mobile.destroy
    if @mobile.save
      redirect_to area_mobiles_path(@area), notice: 'Mobile was sucessfully deleted.'
    else
      redirect_to area_mobiles_path(@area), notice: 'Something went wrong.'
    end
  end
  
  def edit_multiple
    
    if params[:mobile_ids]
  
      @mobiles = Mobile.find(params[:mobile_ids])
  
      if params[:commit] == "Delete Selected"
        @mobiles.each do |mobile|
          mobile.destroy
        end
        redirect_to area_mobiles_path(@area), notice: 'Deleted multiple mobiles.'
      end
      if params[:commit] == "Update Mobiles"
        if !params[:add_special].blank?
          @mobiles.each do |mobile|
            if mobile.specials.where(:name => params[:add_special]).count < 1
              mobile.specials.create( :special_type => 'M',
                                      :name => params[:add_special],
                                      :extended_value_1 => '-1',
                                      :extended_value_2 => '-1',
                                      :extended_value_3 => '-1',
                                      :extended_value_4 => '-1',
                                      :extended_value_5 => '-1',
                                      :mobile_id => mobile.id
                                      )
            end
          end
        end
        if !params[:remove_special].blank?
          @mobiles.each do |mobile|
            if mobile.specials.where(:name => params[:remove_special]).count > 0
              mobile.specials.where(:name => params[:remove_special]).first.destroy
            end
          end
        end
        
        @mobiles.reject! do |mobile|
          mobile.update_attributes(mobile_params.reject { |k,v| v.blank? })
        end
        if @mobiles.empty?
          redirect_to area_mobiles_path(@area), notice: 'Updated multiple mobiles.'
        else
          render "edit_multiple"
        end
      end
    else
      redirect_to area_mobiles_path(@area), notice: 'No mobiles selected.'
    end
  end

  private
    def set_mobile
      @mobile = Mobile.find(params[:id])
    end
    
    def set_area
        @area = Area.find(params[:area_id])
    end
    
    def mobile_params
      params.require(:mobile).permit(:vnum, :keywords, :sdesc, :ldesc,
                                     :look_desc, :act_flags, :affect_flags,
                                     :alignment, :level, :sex, :langs_known,
                                     :lang_spoken, :spell, :area_id,
                                     :common, :dwarven, :elven, :gnomish, 
                                     :halfling, :aarakocra, :giant, :minotaur,
                                     :ogre, :thoras, :goblin, :drow, :kobold,
                                     :orc, :troll, :sahaguin, :god,
                                     :sentinel, :scavenger, :plant, :aggressive,
                                     :stay_area, :wimpy, :train, :practice, 
                                     :super_wimpy, :assist_same, :assist,
                                     :assist_always, :swim, :water_only, 
                                     :animal, :no_wear_eq, :no_corpse,
                                     :fireproof, :intelligent, :cloaked,
                                     :no_random_eq,
                                     :blind, :invisible, :detect_evil,
                                     :detect_invis, :detect_magic,
                                     :detect_hidden, :detect_good, :sanctuary,
                                     :faerie_fire, :infrared, :curse, :no_steal,
                                     :poison, :protect_from_evil,
                                     :protect_from_good, :sneak, :hide, :sleep,
                                     :charm, :flying, :passdoor, :no_trace,
                                     :no_sleep, :no_summon, :no_charm,
                                     :improved_invis
                                     )
    end
end
