class TrimestersController < ApplicationController
  def index
    @trimesters = Trimester.all
  end

  def show
    @trimester = Trimester.find_by(params[:id])
  end
end
