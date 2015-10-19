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
    end
  end

  def full_title
    app_name = Statusify.app_name
    title = content_for :title
    if title
      "#{title} | #{app_name}"
    else
      "#{app_name}"
    end
  end

  def markdown(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true)
    @markdown.render(content).html_safe
  end
end
