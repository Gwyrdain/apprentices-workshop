include ActionView::Helpers::OutputSafetyHelper

class AreasController < ApplicationController
  before_action :authenticate_user!#, except: [:index]
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy] #[:show, :edit, :update, :destroy]
  before_action :can_user_view, only: [:show, :edit]

  respond_to :html

  def index
#   For now, show all... later show only the user's areas.
    @areas = Area.all
#    @areas = Area.where(user_id: current_user.id)
  end

  def show
    if params[:download]
      $area_file = render_to_string(:partial => 'areas/areafile').gsub('&#39;',"'").gsub('&quot;','"').gsub('&amp;','&').gsub('&lt;','<').gsub('&gt;','>')
      send_data($area_file , :filename => @area.name + ".are")
      #render :text => $area_file.force_encoding('US-ASCII').encoding.name
    end
    if params[:preview]
      render('areas/areapreview')
    end
    if params[:review]
      render('areas/areareview')
    end
    if params[:rotate]
      direction = params[:direction].to_i
      # -1 is for rotate 90°, -2 is for rotate 180°, -3 is for rotate 270°
      report = 'Rotating '
      report = "#{report} 90°\n\n"  if direction == -1
      report = "#{report} 180°\n\n" if direction == -2
      report = "#{report} 270°\n\n" if direction == -3
      
        @area.exits.each do |exit|
          if exit.direction < 4 # ignore up / down
            $new_direction = ( exit.direction + direction ) % 4 
            report = report + "Room #{exit.room.vnum}: #{exit.room.name} -- Old D: #{exit.direction} #{exit.direction_word} => "
            exit.update_attribute(:direction, $new_direction)
            report = report + "New D: #{exit.direction} #{exit.direction_word}.\n"
          else
            report = report + "Room #{exit.room.vnum}: #{exit.room.name} -- Old D#: #{exit.direction} #{exit.direction_word} (Unchanged for up/down}.\n"
          end
        end
      render('areas/arearotate', locals: {report: report})
      #render :text => report 
      #redirect_to @area, notice: 'Area exit directions were rotated. Any randomize resets should be manually reviewed.'
    end
  end

  def new
    @area = current_user.areas.build

    @area.flags ||= 0
    @area.vnum_qty ||= 100
    @area.default_terrain ||= 0
    @area.default_room_flags ||= 0
    @area.misc_flags ||= 0
    
  end

  def edit
    
  end

  def create
    if not params[:area]
      @area = current_user.rooms.build
    end

    @area = current_user.areas.create(area_params)

    @area.flags ||= 0
    @area.vnum_qty ||= 100
    @area.default_terrain ||= 0
    @area.default_room_flags ||= 0
    @area.misc_flags ||= 0

    if @area.save
      redirect_to @area, notice: 'Area was sucessfully created.'
    else
      render action: 'new'
    end
  end
  
  def import
    if params[:parse_only]
      render :text => Area.import(params[:file], true)
    else
      area_info = Area.import(params[:file], false)
      import_area( area_info )
      redirect_to areas_path, notice: 'Area imported.'
    end
  end

  def update
    if @area.update(area_params)
      if params[:ownership]
        redirect_to areas_path, notice: 'Ownership transfered.'
      else
        redirect_to @area, notice: 'Area was sucessfully updated.'
      end
    else
      render action: 'edit'
    end     
  end
  
  def destroy
    @area.destroy
    redirect_to areas_url
  end

  private
    def set_area
      @area = Area.find(params[:id])
    end

    def area_params
      params.require(:area).permit(:user_id, :name, :author, :area_number,
                                   :vnum_qty, :manmade, :city, :forest,
#                                   :limited, :aerial, :reserved, :arena, <-- These area flags removed
                                   :quest, :novnum, :no_save, :default_terrain, 
                                   :default_room_flags, :dark, :no_sleep,
                                   :no_mob, :indoors, :foggy, :fire, :lava,
                                   :private_room, :peaceful, :solitary,
                                   :no_recall, :no_steal, :notrans,
                                   :no_spell, :seafloor, :no_fly, :holy_ground,
                                   :fly_ok, :no_quest, :no_item, :no_vnum,
                                   :misc_flags, :share_publicly,
                                   :description, :lowlevel, :highlevel,
                                   :file, :use_rulers, :flags, :installed,
                                   :show_formatted_blocks, :revision,
                                   :parse_only
                                  )
    end
end


def correct_user
  #@area = current_user.areas.find_by(id: params[:id])
  #redirect_to areas_path, notice: "Not authorized to edit this area" if @area.nil?
  if ( current_user.id == @area.user_id || @area.shared_with?(current_user) || current_user.is_admin? )
    # Proceed
  else
    redirect_to :back, notice: "Not authorized to edit this area"
  end
end

def can_user_view
  if ( current_user.id == @area.user_id || @area.shared_with?(current_user) || current_user.is_admin? || @area.share_publicly? )
    # Proceed to view
  else
    redirect_to :back, notice: "Not authorized to view this area"
  end

end

def import_area( area_info )
  
  $areas_with_same_name = Area.where(:name => area_info["header_info"]["name"])
  
  if $areas_with_same_name.count > 0
    $new_rev = $areas_with_same_name.order(revision: :desc).first.revision + 1
  else
    $new_rev = 0
  end
  
  $new_area = current_user.areas.create(
    :vnum_qty => 1000, ## maybe reset lower after import when high vnums known?
    :default_terrain => 0,
    :default_room_flags => 0,
    :misc_flags => 2**2, # set show forbatted blocks to on
    :name => area_info["header_info"]["name"],
    :author => area_info["header_info"]["author"],
    :lowlevel => area_info["header_info"]["range_low"],
    :highlevel => area_info["header_info"]["range_high"],
    :area_number => area_info["header_info"]["area_number"],
    :revision => $new_rev
    )
  
  if area_info["header_info"]["flags"]
    $new_area.update(
      :flags => area_info["header_info"]["flags"],
      )
  end
  
  
  if area_info["header_info"]["description"]
    $new_area.update(
      :description => area_info["header_info"]["description"]
      )
  end
    
  if area_info["helps_block"]
      area_info["helps_block"].each_value do |help_record|
      $new_area.helps.create(
        :min_level => help_record["min_level"].to_i,
        :keywords => help_record["keywords"],
        :body => help_record["body"]
        )
    end
  end # helps_block
  
  if area_info["mobiles_block"]
    area_info["mobiles_block"].each_value do |mobile_record|
      $vnum = mobile_record["vnum"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
      $new_mobile = $new_area.mobiles.create(
        :vnum => $vnum,
        :keywords => mobile_record["keywords"],
        :sdesc => mobile_record["sdesc"],
        :ldesc => mobile_record["ldesc"],
        :look_desc => mobile_record["look_desc"],
        :act_flags => mobile_record["act_flags"].to_i,
        :affect_flags => mobile_record["affect_flags"].to_i,
        :alignment => mobile_record["alignment"].to_i,
        :level => mobile_record["level"].to_i,
        :sex => mobile_record["sex"].to_i,
        )
        
      if mobile_record["langs_known"]
         $new_mobile.update(
           :langs_known => mobile_record["langs_known"],
           :lang_spoken => mobile_record["lang_spoken"]
           )
      else
         $new_mobile.update(
           :langs_known => 0,
           :lang_spoken => 0
           )
      end
      
      $new_mobile.update(:animal => true)     if mobile_record["animal"]
      $new_mobile.update(:no_wear_eq => true) if mobile_record["no_wear_eq"]
      
      $new_mobile.update(:spell => mobile_record["one_spell"])      if mobile_record["one_spell"]
      
    end # each do
  end # mobiles_block
  
  if area_info["objects_block"]
    area_info["objects_block"].each_value do |object_record|
      $vnum = object_record["vnum"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
      $new_obj = $new_area.objs.create(
        :vnum        => $vnum,
        :keywords    => object_record["keywords"],
        :sdesc       => object_record["sdesc"],
        :ldesc       => object_record["ldesc"],
        :object_type => object_record["object_type"].to_i,
        :extra_flags => object_record["extra_flags"].to_i,
        :wear_flags  => object_record["wear_flags"].to_i,
        :misc_flags  => 0,
        :v0          => object_record["v0"].to_i,
        :v1          => object_record["v1"].to_i,
        :v2          => object_record["v2"].to_i,
        :v3          => object_record["v3"].to_i,
        :weight      => object_record["weight"].to_i,
        :cost        => object_record["cost"].to_i
        )
        
      $new_obj.update(:flammable => true)         if object_record["flammable"]
      $new_obj.update(:metallic => true)          if object_record["metallic"]
      $new_obj.update(:two_handed => true)        if object_record["two_handed"]
      $new_obj.update(:underwater_breath => true) if object_record["underwater_breath"]
      
      if object_record["extra_descs"]
        object_record["extra_descs"].each_value do |oxdesc|
          $new_obj.oxdescs.create(
            :keywords     => oxdesc["keywords"],
            :description  => oxdesc["description"]
            )
        end
      end
      
      if object_record["applies"]
        object_record["applies"].each_value do |apply|
          $new_obj.applies.create(
            :apply_type => apply["apply_type"].to_i,
            :amount     => apply["amount"].to_i
            )
        end
      end
        
    end
  end # objects_block

  if area_info["rooms_block"]
    area_info["rooms_block"].each_value do |room_record|
      $vnum = room_record["vnum"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
      $new_room = $new_area.rooms.create(
        :vnum         => $vnum,
        :name         => room_record["name"],
        :description  => room_record["description"],
        :room_flags   => room_record["room_flags"].to_i,
        :terrain      => room_record["terrain"].to_i
        )
        
      if room_record["extra_descs"]
        room_record["extra_descs"].each_value do |rxdesc|
          $new_room.rxdescs.create(
            :keywords     => rxdesc["keywords"],
            :description  => rxdesc["description"]
            )
        end
      end
      
      if room_record["exits"]
        room_record["exits"].each_value do |exit|
          
          $new_room.exits.create(
            :direction    => exit["direction"].to_i,
            :description  => exit["description"],
            :keywords     => exit["keywords"],
            :exittype     => exit["exittype"].to_i,
            :keyvnum      => exit["key_vnum"].to_i, #needs work
            :exit_room_id => exit["exit_vnum"].to_i, #needs work
            :name         => exit["name"],
            )
        end
      end
    end # do each room
    
    # connect all internal exits...
    $new_area.exits.each do |exit|
      
      if ( exit.keyvnum / 100 ) == $new_area.area_number
        $keyvnum = exit.keyvnum - ($new_area.area_number * 100)
        $matches = $new_area.objs.where(:vnum => $keyvnum)
        if $matches.count > 0
          exit.update(
            :keyvnum => $matches.first.id
            )
        end
      end
      # connect all internal keys...
      if ( exit.exit_room_id / 100 ) == $new_area.area_number
        $vnum = exit.exit_room_id - ($new_area.area_number * 100)
        $matches = $new_area.rooms.where(:vnum => $vnum)
        if $matches.count > 0
          exit.update(
            :exit_room_id => $matches.first.id
            )
        end
      end
    
    end
    
  end # rooms_block

  if area_info["strings_block"]
    area_info["strings_block"].each_value do |string_record|
      $vnum = string_record["vnum"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
      $new_area.area_strings.create(
        :vnum => $vnum,
        :message_to_pc => string_record["message_to_pc"],
        :message_to_room => string_record["message_to_room"]
        )
    end
  end# strings_block
  
  if area_info["resets_block"]
    
    last_mobile_reset = 0
    last_object_reset = 0
    
    area_info["resets_block"].each_value do |reset_record|
      reset_type = reset_record["reset_type"]
      # M / Q / O / R ... load it directly
      if ( reset_type == 'M' || reset_type == 'Q' )
        
        $mobile_vnum  = reset_record["val_2"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
        $room_vnum    = reset_record["val_4"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
        $matches = $new_area.mobiles.where(:vnum => $mobile_vnum)
        if $matches.count > 0
          $mobile_id = $matches.first.id
        end
        $matches = $new_area.rooms.where(:vnum => $room_vnum)
        if $matches.count > 0
          $room_id = $matches.first.id
        end

        $new_mobile_reset = $new_area.resets.create(
          :reset_type => reset_record["reset_type"],
          :val_1      => reset_record["val_1"].to_i,
          :val_2      => $mobile_id,
          :val_3      => reset_record["val_3"].to_i,
          :val_4      => $room_id
          )
        last_mobile_reset = $new_mobile_reset
      end

      if reset_type == 'O'
        
        $obj_vnum   = reset_record["val_2"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
        $room_vnum  = reset_record["val_4"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
        $matches = $new_area.objs.where(:vnum => $obj_vnum)
        if $matches.count > 0
          $obj_vnum = $matches.first.id
        end
        $matches = $new_area.rooms.where(:vnum => $room_vnum)
        if $matches.count > 0
          $room_id = $matches.first.id
        end
        
        $new_obj_reset = $new_area.resets.create(
          :reset_type => reset_record["reset_type"],
          :val_1      => reset_record["val_1"].to_i,
          :val_2      => $obj_vnum,
          :val_3      => reset_record["val_3"].to_i,
          :val_4      => $room_id
          )
        last_object_reset = $new_obj_reset
      end

      # E / G ... make a sub-reset, need to know the last M or Q
      if ( reset_type == 'E' || reset_type == 'G' )
        
        $obj_vnum   = reset_record["val_2"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
        $matches = $new_area.objs.where(:vnum => $obj_vnum)
        if $matches.count > 0
          $obj_vnum = $matches.first.id
        end

        $new_sub_reset = last_mobile_reset.sub_resets.create(
          :reset_type   => reset_record["reset_type"],
          :val_1        => reset_record["val_1"].to_i,
          :val_2        => $obj_vnum,
          :val_3        => reset_record["val_3"].to_i,
          :val_4        => reset_record["val_4"].to_i,
          )
      end

      # P, need to know the last O (or I in theory)
      if ( reset_type == 'P')
        
        $obj_vnum   = reset_record["val_2"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
        $matches = $new_area.objs.where(:vnum => $obj_vnum)
        if $matches.count > 0
          $obj_vnum = $matches.first.id
        end

        $new_mobile_reset = $new_area.resets.create(
          :reset_type   => reset_record["reset_type"],
          :val_1        => reset_record["val_1"].to_i,
          :val_2        => $obj_vnum,
          :val_3        => reset_record["val_3"].to_i,
          :val_4        => 0,
          :parent_type  => 'reset',
          :parent_id    => last_object_reset.id
          )
      end
      
      # D ... make a change in the exit record
      if reset_type == 'D'
        
        $room_vnum  = reset_record["val_2"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
        $room = $new_area.rooms.where(:vnum => $room_vnum).first
        $exit = $room.exits.where(:direction => reset_record["val_3"].to_i).first
        $exit.update(
          :reset => reset_record["val_4"].to_i
          )
          
      end
      
      # R
      if reset_type == 'R'
        
        $room_vnum  = reset_record["val_2"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
        $room = $new_area.rooms.where(:vnum => $room_vnum).first
        $new_area.resets.create(
          :reset_type => reset_record["reset_type"],
          :val_1      => 0,
          :val_2      => $room.id,
          :val_3      => reset_record["val_3"].to_i,
          :val_4      => 0
          )
      end


    end
  end# strings_block
  
  if area_info["shops_block"]
    area_info["shops_block"].each_value do |shop_record|
      $mobile_vnum  = shop_record["mobile_vnum"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
      shop_mobile = $new_area.mobiles.where(:vnum => $mobile_vnum).first

      shop_mobile.shops.create(
        :buy_type_1 => shop_record["buy_type_1"],
        :buy_type_2 => shop_record["buy_type_2"],
        :buy_type_3 => shop_record["buy_type_3"],
        :buy_type_4 => shop_record["buy_type_4"],
        :buy_type_5 => shop_record["buy_type_5"],
        :open_hour  => shop_record["open_hour"],
        :close_hour => shop_record["close_hour"],
        :race       => shop_record["race"],
        )
    end
  end# shops_block
  
  if area_info["specials_block"]
    area_info["specials_block"].each_value do |special_record|
      
      special_type = special_record["type"]

      $mobile_vnum  = special_record["vnum"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
      special_mobile = $new_area.mobiles.where(:vnum => $mobile_vnum).first

      if ( special_type == 'M' )
        special_mobile.specials.create(
          :special_type => special_record["type"],
          :name => special_record["name"],
          :extended_value_1 => -1,
          :extended_value_2 => -1,
          :extended_value_3 => -1,
          :extended_value_4 => -1,
          :extended_value_5 => -1
          )
      end
      
      if ( special_type == 'N' )
        special_mobile.specials.create(
          :special_type => special_record["type"],
          :name => special_record["name"],
          :extended_value_1 => special_record["extended_value_1"].to_i,
          :extended_value_2 => special_record["extended_value_2"].to_i,
          :extended_value_3 => special_record["extended_value_3"].to_i,
          :extended_value_4 => special_record["extended_value_4"].to_i,
          :extended_value_5 => special_record["extended_value_5"].to_i
          )
      end
      
    end
  end# specials_block
  
  if area_info["rspecs_block"]
    area_info["rspecs_block"].each_value do |rspec_record|
      
      rspec_type = rspec_record["type"]

      $room_vnum  = rspec_record["vnum"].to_i - ( area_info["header_info"]["area_number"].to_i * 100 )
      rspec_room = $new_area.rooms.where(:vnum => $room_vnum).first

      if ( rspec_type == 'D' )
        rspec_room.room_specials.create(
          :room_special_type => rspec_record["type"],
          :name => rspec_record["name"],
          :extended_value_1 => -1,
          :extended_value_2 => -1,
          :extended_value_3 => -1,
          :extended_value_4 => -1,
          :extended_value_5 => -1
          )
      end
      
      if ( rspec_type == 'E' )
        rspec_room.room_specials.create(
          :room_special_type => rspec_record["type"],
          :name => rspec_record["name"],
          :extended_value_1 => rspec_record["extended_value_1"].to_i,
          :extended_value_2 => rspec_record["extended_value_2"].to_i,
          :extended_value_3 => rspec_record["extended_value_3"].to_i,
          :extended_value_4 => rspec_record["extended_value_4"].to_i,
          :extended_value_5 => rspec_record["extended_value_5"].to_i
          )
      end
      
    end
  end# rspecs_block
    
end