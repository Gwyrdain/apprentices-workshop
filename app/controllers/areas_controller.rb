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
    area_info = Area.import(params[:file])
    
    import_area( area_info )
    
    redirect_to areas_path, notice: 'Area imported.'
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
                                   :show_formatted_blocks
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
  current_user.areas.create(
    :vnum_qty => 100, ## fix this?
    :default_terrain => 0,
    :default_room_flags => 0,
    :misc_flags => 0,
    :name => area_info["header_info"]["name"],
    :author => area_info["header_info"]["author"],
    :flags => area_info["header_info"]["flags"],
    :lowlevel => area_info["header_info"]["range_low"],
    :highlevel => area_info["header_info"]["range_high"],
    :area_number => 1 ## fix this
    )
end