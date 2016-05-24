# require essential libraries
require 'sinatra'

# require other helper libraries
require_relative './helpers/helper.rb'

# adds configurations
require './config/environment'

# API setup
class RubyStarter < Sinatra::Base
  # add helpers
  helpers Helpers

  # routes
  get '/?' do
    'Root route up and running!'
  end
end