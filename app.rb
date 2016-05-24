# require essential libraries
require 'sinatra'
require 'http'

# require other helper libraries
require_relative './helpers/helper.rb'

# adds configurations
require './config/environment'

# API setup
class RubyStarter < Sinatra::Base
  # add helpers
  helpers Helpers

  API_URL = ENV['API_URL']

  # routes
  get '/?' do
    haml :index
  end

  # classify piece of text
  get '/classify' do
    @api_url = API_URL
    response = HTTP.post(@api_url, :json => {:lang=>"und", :text =>"#{params['text']}"})
    emotion_content = JSON.parse(response)

    # collection all emotion classes returned
    if emotion_content["groups"]
      @emotion_groups = emotion_content["groups"].map {|g| g["name"]}
    end

    # check if ambiguous
    if emotion_content["ambiguous"]
      @emotion_ambiguity_status = emotion_content["ambiguous"]
    end

    haml :result
  end
end