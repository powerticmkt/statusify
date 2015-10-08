module ApplicationHelper
  include IncidentsHelper
  def link_to_incident(id, action)
    # Generates a link to the specified action.
    base = "/incidents/#{id}/"
    case action
      when 'view'
        base + ''
      when 'edit'
        base + 'edit'
      when 'deactivate'
        base + 'deactivate'
      when 'delete'
        base + 'delete'
      else
        nil
    end
  end
  def full_title
    app_name ||= APP_CONFIG['name']
    if :title
      "#{content_for(:title)} | #{app_name}"
    else
      "#{app_name}"
    end
  end
end
