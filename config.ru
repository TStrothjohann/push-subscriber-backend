require "./app/push_subscriber.rb"
require "./app/models/Tag.rb"
require "./app/models/Channel.rb"
require "./app/models/Push.rb"
require "dotenv"
require "net/http"
require 'uri'
require "urbanairship"

UA = Urbanairship

Dotenv.load
run PushSubscriber