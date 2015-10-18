module PagesHelper
  def cache_key_for_index
    count = Incident.count
    max_updated_at = Incident.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "incidents/all-#{count}-#{max_updated_at}"
  end

  def visible(incident, show_private = user_signed_in?)
    incident.public? || show_private
  end

  def timeline_class(current)
    # This alternatively sets the timeline-inverted class
    current ? 'timeline-inverted' : nil
  end
end