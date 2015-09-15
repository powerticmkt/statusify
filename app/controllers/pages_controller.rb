class PagesController < ApplicationController
  def index
    @active_incidents = Incident.find_by(active: true)
  end
end
