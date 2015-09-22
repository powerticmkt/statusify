module ApplicationHelper
  def active_incidents
    @active_incidents ||= Incident.all.select { |m| m.active == true }
  end

  def all_incidents
    if signed_in?
      @all_incidents ||= Incident.all.order('updated_at DESC')
    else
      @all_incidents ||= Incident.all.order('updated_at DESC').select { |i| i.public == true}
    end
  end

  def last_event(incident)
    return if incident.class != Incident
    last_event = incident.events.order('updated_at DESC').first
    return last_event
  end

  def all_events(incident)
    return if incident.class != Incident
    all_events = incident.events.order('updated_at DESC')
  end

end
