class DashboardController < ApplicationController

  before_action :require_login

  def index
    @new_incident = Incident.new
  end

  def new_incident
    @new_incident = Incident.new(incident_params)
    @new_incident[:user_id] = current_user.id
    if @new_incident.save
      # Handle successful save
      redirect_to root_path
    else
      render 'dashboard/index'
    end
  end

  private
    def incident_params
      params.require(:incident).permit(:name, :message, :begins, :ends, :component)
    end
end
