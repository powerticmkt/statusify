module ApplicationHelper
  def active_incidents
    @active_incidents ||= Incident.all.select { |m| m.active == true }
  end
end
