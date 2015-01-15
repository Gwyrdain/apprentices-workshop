class HelpsController < ApplicationController

    def index
        @area = Area.find(params[:area_id])
        @helps = @area.helps
    end

    def show
        @area = Area.find(params[:area_id])
        @help = Help.find(params[:id])
    end

    def new
        @area = Area.find(params[:area_id])
        @help = Help.new(:area_id => params[:area_id])

    end
    
    def edit
        @area = Area.find(params[:area_id])
        @help = Help.find(params[:id])
    end

    def create
        @area = Area.find(params[:area_id])
        @help = @area.helps.create(help_params)
        redirect_to area_path(@area)
    end

  def update
    @area = Area.find(params[:area_id])
    @help = Help.find(params[:id])
    if @help.update(help_params)
      redirect_to area_help_path(@area, @help), notice: 'Area was sucessfully updated.'
    else
      render action: 'edit'
    end     
  end

    private
        def help_params
            params.require(:help).permit(:min_level, :keywords, :body )
        end
    
end
