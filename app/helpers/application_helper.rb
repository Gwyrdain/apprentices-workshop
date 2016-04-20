module ApplicationHelper

  def ruler
    if current_user.use_rulers?
        "<textarea class=\"text_field form-control\" rows=\"1\" disabled=\"disabled\">#{WORDWRAP_RULER}</textarea>".html_safe
    end
  end

end
