module ApplicationHelper

  def ruler
    if @area.use_rulers?
        "<textarea class=\"text_field form-control\" rows=\"1\" disabled=\"disabled\">#{ApplicationController::WORDWRAP_RULER}</textarea>".html_safe
    end
  end

end
