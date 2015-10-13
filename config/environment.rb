# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Pull in our module so that our config is available
require "#{Rails.root}/lib/statusify/statusify.rb"
include Statusify