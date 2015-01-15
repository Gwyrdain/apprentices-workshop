class HelpsController < ApplicationController

    def index
        @area = Area.find(params[:area_id])
        @helps = @area.helps
    end

    def show
        @area = Area.find(params[:area_id])
    end

    def new
        @area = Area.find(params[:area_id])
        @help = Help.new(:area_id => params[:area_id])
#sample: @property = Property.new(:agency_id => params[:agency_id])
        
    end
    
    def edit
        
    end

    def create
        @area = Area.find(params[:area_id])
        @help = @area.helps.create(help_params)
        redirect_to area_path(@area)
    end
    
    private
        def help_params
            params.require(:help).permit(:min_level, :keywords, :body )
        end
    
end
