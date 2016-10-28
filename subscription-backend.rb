require 'dotenv'
require 'urbanairship'
UA = Urbanairship
airship = UA::Client.new(key:'application_key', secret:'master_secret')