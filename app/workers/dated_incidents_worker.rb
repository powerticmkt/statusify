class DatedIncidentsWorker
  include Sidekiq::Worker
  include IncidentsHelper
  def perform
    dated_incidents(true)
  end
end
