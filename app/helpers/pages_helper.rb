module PagesHelper
  def cache_key_for_index
    count = Incident.count
    max_updated_at = Incident.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "incidents/all-#{count}-#{max_updated_at}"
  end

  def visible(incident)
    incident.public? || signed_in?
  end
end