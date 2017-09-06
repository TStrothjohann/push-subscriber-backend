require 'sinatra/base'
require 'sinatra/partial'
require 'sinatra/json'
require 'dotenv'

class PushSubscriber < Sinatra::Base
  register Sinatra::Partial
  
  before do
    response['Access-Control-Allow-Origin'] = @cors_domain = "*"
  end
  
  get '/' do
    return json :hello => "World"
  end

  get '/user-info' do
    mytag = Tag.new
    mytag.named_user = params['ssoid']
    json mytag.ua_get_user_info
  end

  get '/channel' do
    channel = Channel.new
    channel.id = params['channel_id']
    json channel.ua_get_channel_info
  end

  get '/channel/has-tag' do
    channel = Channel.new
    channel.id = params['channel_id']
    channel.tag_name = params['tag_name']
    channel.tag_group_name = params['tag_group_name']
    json channel.ua_channel_has_tag
  end

  get '/channel/add-tag' do
    channel = Channel.new
    channel.id = params['channel_id']
    channel.tag_name = params['tag_name']
    channel.tag_group_name = params['tag_group_name']
    json channel.ua_channel_add_tag
  end

  get '/channel/remove-tag' do
    channel = Channel.new
    channel.id = params['channel_id']
    channel.tag_name = params['tag_name']
    channel.tag_group_name = params['tag_group_name']
    json channel.ua_remove_tag
  end

  get '/add-tag' do
    mytag = Tag.new
    mytag.name = params['tag_name']
    mytag.named_user = params['ssoid']
    mytag.tag_group_name = params['tag_group_name']
    json mytag.ua_add_tag
  end

  get '/get-tags' do
    mytag = Tag.new
    mytag.named_user = params['ssoid']
    json mytag.ua_get_info    
  end

  get '/has-tag' do
    mytag = Tag.new
    mytag.name = params['tag_name']
    mytag.named_user = params['ssoid']
    mytag.tag_group_name = params['tag_group_name']
    json :has_tag => mytag.ua_has_tag 
  end

  get '/remove-tag' do
    mytag = Tag.new
    mytag.name = params['tag_name']
    mytag.named_user = params['ssoid']
    mytag.tag_group_name = params['tag_group_name']
    json mytag.ua_remove_tag
  end

  get '/active-channels' do
    mytag = Tag.new
    mytag.named_user = params['ssoid']    
    json :active_channels => mytag.ua_active_channels
  end

end