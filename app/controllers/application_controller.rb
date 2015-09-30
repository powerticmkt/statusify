class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  # Include our backports
  require "#{Rails.root}/lib/statusify/backports.rb"
  include BackPorts
end
