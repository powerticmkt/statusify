class IncidentsController < ApplicationController
  skip_before_filter :verify_authenticity_token if ENV['STRESS-TEST']
  before_action :require_login, except: [:view]

  def new
    @incident ||= current_user.incidents.new
    @incident.events.build
  end

  def create
    @incident = current_user.incidents.new(incident_params)
    if @incident.save
      # Handle successful save
      flash[:success] = 'Incident created successfully.'
      dated_incidents(true)
      redirect_to root_path
      response.headers['status'] = 'success'
    else
      response.headers['status'] = 'failed'
      render 'incidents/new'
    end
  end

  def edit
    @incident ||= Incident.find_by_id(params[:id])
    @event = Event.find_by_incident_id(params[:id])
    redirect_to root_path if @incident.nil?
    dated_incidents(true)
  end

  def update
    # Builds a new event for each update.
    @incident = Incident.find_by_id(params[:id])
    @incident.name = incident_params[:name]
    @incident.component = incident_params[:component]
    @incident.severity = incident_params[:severity]
    @incident.public = incident_params[:public]
    event_params = { message: incident_params[:event][:message], status: incident_params[:event][:status] }
    @event = @incident.events.build(event_params)
    if @incident.save || @event.save
      response.headers['status'] = 'success'
      flash[:success] = 'Incident updated successfully.'
      dated_incidents(true)
      redirect_to root_path
    else
      response.headers['status'] = 'failed'
      flash[:danger] = 'Please fill all entries.'
      redirect_to "/incidents/#{@incident.id}"
    end
  end

  def delete
    i = Incident.find_by_id(params[:id])
    if i
      response.headers['status'] = 'success'
      i.delete
      flash[:success] = 'Incident deleted successfully.'
      dated_incidents(true)
    else
      response.headers['status'] = 'failed'
      flash[:danger] = 'Failed to delete incident.'
    end
    redirect_to root_url
  end

  def deactivate
    @incident = Incident.find_by_id(params[:id])
    if @incident
      @incident.active = false
      @incident.save
      flash[:success] = 'Deactivated incident successfully.'
      response.headers['status'] = 'success'
    end
    redirect_to root_path
  end

  def view
    @incident = Incident.find_by_id(params[:id])
    unless @incident
      redirect_to root_path
      flash[:warning] = 'Unable to find that incident'
    end
    if @incident.public? || signed_in?
      render 'incidents/view'
    else
      redirect_to root_path
      flash[:warning] = 'Unable to find that incident'
    end
  end
  
  private

  def incident_params
    params.require(:incident).permit(:name, :status, :component, :severity, :public, events_attributes: [:status, :message], event: [:status, :message])
  end
end
