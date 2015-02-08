class SubResetsController < ApplicationController
  before_action :set_sub_reset, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @sub_resets = SubReset.all
    respond_with(@sub_resets)
  end

  def show
    respond_with(@sub_reset)
  end

  def new
    @sub_reset = SubReset.new
    respond_with(@sub_reset)
  end

  def edit
  end

  def create
    @sub_reset = SubReset.new(sub_reset_params)
    @sub_reset.save
    respond_with(@sub_reset)
  end

  def update
    @sub_reset.update(sub_reset_params)
    respond_with(@sub_reset)
  end

  def destroy
    @sub_reset.destroy
    respond_with(@sub_reset)
  end

  private
    def set_sub_reset
      @sub_reset = SubReset.find(params[:id])
    end

    def sub_reset_params
      params.require(:sub_reset).permit(:reset_type, :val_1, :val_2, :val_3, :val_4, :reset_id)
    end
end
