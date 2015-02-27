module RoomsHelper
  
  def obj_room_view(id)
    output = ''
    if Obj.exists?(:id => id)
      this_obj = Obj.find(id)
      output = "<font color=green>"
      
      output = output << "(Magical) " if this_obj.magic?
      output = output << "(Glowing) " if this_obj.glow?
      output = output << "(Humming) " if this_obj.hum?
      output = output << "(Invis) "   if this_obj.invis?
      
      output = output << "#{this_obj.ldesc}</font>"
      return output.html_safe
    else
      return '*** ERROR: OBJECT NOT FOUND ***'
    end
  end
  
  def obj_inv_view(id)
    output = ''
    if Obj.exists?(:id => id)
      this_obj = Obj.find(id)
      output = "<font color=green>"
      
      output = output << "(Magical) " if this_obj.magic?
      output = output << "(Glowing) " if this_obj.glow?
      output = output << "(Humming) " if this_obj.hum?
      output = output << "(Invis) "   if this_obj.invis?
      
      output = output << "#{this_obj.sdesc}</font>"
      return output.html_safe
    else
      return '*** ERROR: OBJECT NOT FOUND ***'
    end
  end
  
  def mobile_room_view(id)
    output = ''
    if Mobile.exists?(:id => id)
      this_mobile = Mobile.find(id)
      output = "<font color=white>"
      
      output = output << "(Invis) "      if ( this_mobile.invisible? || this_mobile.improved_invis? )
      output = output << "(Hide) "       if this_mobile.hide?
      output = output << "(White Aura) " if this_mobile.sanctuary?
      output = output << "(<font color=blue>Light Blue Aura</font>) " if this_mobile.alignment == 1000
      output = output << "(<font color=red>Light Red Aura</font>) "  if this_mobile.alignment == -1000
      
      output = output << "</font><font color=purple>"
      output = output << "#{this_mobile.ldesc}</font>"
      return output.html_safe
    else
      return '*** ERROR: MOBILE NOT FOUND ***'
    end
  end
  
end
