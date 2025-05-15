class TrimestersController < ApplicationController
  before_action :set_trimester, only: %i[edit update]
  def index
    @trimesters = Trimester.all
  end

  def edit
  end

  def update
    if params[:trimester][:application_deadline].blank?
      render plain: 'App deadlines requried', status: :bad_request
    elsif !valid_date?(params[:trimester][:application_deadline])
      render plain: 'Invalid date', status: :bad_request
    elsif @trimester.update(trimester_params)
      redirect_to trimesters_path, notice: 'updated -trimester'
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render plain: 'not found- trimester', status: :not_found
  end

  private

  def set_trimester
    @trimester = Trimester.find(params[:id])
  end

  def trimester_params
    params.require(:trimester).permit(:application_deadline)
  end

  def valid_date?(str)
    Date.parse(str)
    true
  rescue ArgumentError
    false
  end
end
