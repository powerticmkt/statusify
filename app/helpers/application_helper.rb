module ApplicationHelper
  def active_incidents
    @active_incidents ||= Incident.all.select { |m| m.active == true }
  end

  def all_incidents
    @all_incidents ||= Incident.all
  end
end
