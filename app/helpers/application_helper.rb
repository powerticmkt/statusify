module ApplicationHelper
  def active_incidents
    @active_incidents ||= Incident.all.select { |m| m.active == true }
  end

  def all_incidents
    if signed_in?
      @all_incidents ||= Incident.all
    else
      @all_incidents ||= Incident.all.select { |i| i.public == true}
    end
  end
end
