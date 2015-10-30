class PagesController < ApplicationController
  def index
    render layout: 'dashboard' if signed_in?
  end

  def history
    # The incident history. Shows all the ancient incidents since the index page shows only five of them.
    @dated_incidents = dated_incidents
    # Render the dashboard layout if signed in
    render 'pages/history', layout: 'dashboard' if signed_in?
  end

  def current_status_dot
    if active_incidents.blank?
      url = "#{Statusify.app_url}/up.svg"
    else
      url = "#{Statusify.app_url}/down.svg"
    end
    redirect_to url
  end
end
