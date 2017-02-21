require "./app/push_subscriber.rb"
require "./app/models/Tag.rb"
require "./app/models/Channel.rb"
require "dotenv"
require "urbanairship"

UA = Urbanairship

Dotenv.load
run PushSubscriber