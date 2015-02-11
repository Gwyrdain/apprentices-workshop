class MobilesController < ApplicationController
  before_action :set_mobile, only: [:show, :edit, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :correct_user, only: [:new, :edit, :create, :update, :destroy] #[:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @mobiles = @area.mobiles
  end

  def show
    
  end

  def new
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
      redirect_to area_mobile_path(@area, @mobile), notice: 'Mobile was sucessfully updated.'
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
