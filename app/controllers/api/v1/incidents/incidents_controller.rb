class API::V1::Incidents::IncidentsController < API::V1::BaseController
  before_filter :authenticate_user!, except: [:index]

  def index
    incidents = visible_incidents(authenticate_user)
    render json: incidents, methods: [:status, :events], except: [:user_id, :public, :id]
  end

  def view
    @incident = Incident.find_by_id(params[:id])
    if @incident && visible(@incident, authenticate_user)
      render json: @incident
    else
      head :not_found
    end
  end

  def create
    @incident = Incident.new
    @event = @incident.events.build
    incident = @request['incident']
    if incident
      event = @request['incident']['event']
      incident = incident.except['event'] if event
      @incident.assign_attributes(incident)
    end
    if @incident.save && @event.save
      head :success
    else
      errors = JSON.parse(@incident.errors.to_json).merge(@event.errors)
      render json: errors
    end
  end

end