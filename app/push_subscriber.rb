require 'sinatra/base'
require 'sinatra/partial'
require "sinatra/json"
require 'dotenv'

class PushSubscriber < Sinatra::Base
  register Sinatra::Partial

  get '/' do
    return json :hello => "World"
  end

  get '/add-tag' do
    mytag = Tag.new
    mytag.name = params['name']
    mytag.named_user = params['ssoid']
    json mytag.ua_add_tag
  end

  get '/get-tags' do
    mytag = Tag.new
    mytag.named_user = params['ssoid']
    json mytag.ua_get_info    
  end
end