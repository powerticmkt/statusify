class API::V1::BaseController < ApplicationController
  # Base API controller
  # Mostly a stub as of now
  # Inheriting classes must handle auth themselves
  # But they can use the authenticate_user method in the APIHelper
  include APIHelper
  include PagesHelper
  before_filter :parse_request, :authenticate_user
  # APIs don't need CSRF protection
  skip_before_filter :verify_authenticity_token

  def authenticate_user!
    # Gives a 401 unless the user is authed
    head :unauthorized unless authenticate_user
  end

  def parse_request
    @request = JSON.parse(request.body.read)
  rescue JSON::ParserError
    # No JSON
    @request = nil
  end
end