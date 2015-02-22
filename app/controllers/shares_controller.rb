class SharesController < ApplicationController
  before_action :authenticate_user!#, except: [:index]
  before_action :set_share, only: [:show, :edit, :update, :destroy]
  before_action :set_area, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :shares_correct_user, only: [:new, :update, :destroy] #[:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @shares = @area.shares
  end

  def show
    
  end

  def new
    @share = @area.shares.build

  end

  def edit
    
  end

  def create
    @share = @area.shares.create(share_params)

    if @share.save
      redirect_to area_path(@area), notice: 'Share was sucessfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @share.update(share_params)
      redirect_to area_path(@area), notice: 'Share was sucessfully updated.'
    else
      render action: 'edit'
    end 
  end

  def destroy
    @share.destroy
    if @share.save
      redirect_to area_path(@area), notice: 'Share was sucessfully deleted.'
    else
      redirect_to area_path(@area), notice: 'Something went wrong.'
    end
  end

  private
    def set_share
      @share = Share.find(params[:id])
    end
    
    def set_area
        @area = Area.find(params[:area_id])
    end
    
    def share_params
      params.require(:share).permit(:user_id, :area_id)
    end
end

def shares_correct_user
  if ( current_user.id == @area.user_id || current_user.is_admin? )
    # Proceed
  else
    redirect_to :back, notice: "Only the area owner may modify shares."
  end
end