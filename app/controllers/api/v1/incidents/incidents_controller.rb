class API::V1::Incidents::IncidentsController < API::V1::BaseController

  def index
    incidents = visible_incidents(!!authenticate_user)
    render json: incidents, methods: [:status, :events], except: [:user_id, :public, :id]
  end

end