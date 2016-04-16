class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
#   Constants moved to initializer.
#   WORDWRAP_LENGTH = 75
#   WORDWRAP_RULER = '----+----|----+----|----+----|----+----|----+----|----+----|----+----|----+'
#   DATE_FORMAT = '%F at %I:%M%P'
  
end
