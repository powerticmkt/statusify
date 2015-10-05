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
end
