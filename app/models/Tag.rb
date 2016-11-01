require "urbanairship"
UA = Urbanairship

class Tag
  attr_accessor :name, :named_user
  
  def initialize
    @airship = UA::Client.new(key: ENV['ua_key'], secret: ENV['ua_master_secret'])
  end

  def ua_get_info
    ua_named_user = UA::NamedUser.new(client: @airship)
    ua_named_user.named_user_id = @named_user
    user = ua_named_user.lookup
    return user['body']['named_user']['tags']
  end

  def ua_add_tag
    named_user_tags = UA::NamedUserTags.new(client: @airship)
    named_user_ids = [@named_user] 
    named_user_tags.set_audience(user_ids: named_user_ids)
    named_user_tags.add(group_name: 'subscriptions', tags: [@name])
    named_user_tags.send_request
  end
end