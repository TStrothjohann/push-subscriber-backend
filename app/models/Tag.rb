class Tag
  attr_accessor :name, :named_user, :tag_group_name
  
  def initialize
    @airship = UA::Client.new(key: ENV['ua_key'], secret: ENV['ua_master_secret'])
  end

  def ua_get_info
    ua_named_user = UA::NamedUser.new(client: @airship)
    ua_named_user.named_user_id = @named_user
    user = ua_named_user.lookup
    return user['body']['named_user']['tags']
  end

  def ua_get_user_info
    ua_named_user = UA::NamedUser.new(client: @airship)
    ua_named_user.named_user_id = @named_user
    user = ua_named_user.lookup
    return user
  end

  def ua_add_tag
    named_user_tags = UA::NamedUserTags.new(client: @airship)
    named_user_ids = [@named_user] 
    named_user_tags.set_audience(user_ids: named_user_ids)
    named_user_tags.add(group_name: @tag_group_name, tags: [@name])
    named_user_tags.send_request
  end
  
  def ua_has_tag
    ua_named_user = UA::NamedUser.new(client: @airship)
    ua_named_user.named_user_id = @named_user
    begin
      user = ua_named_user.lookup
      tags = user['body']['named_user']['tags'][@tag_group_name]
      if !tags 
        tags = []
      end
    rescue
      tags = []
    end
    
    return tags.include? @name
  end

  def ua_active_channels
    active_channels = []
    ua_named_user = UA::NamedUser.new(client: @airship)
    ua_named_user.named_user_id = @named_user
    user = ua_named_user.lookup
    channels = user['body']['named_user']['channels']
    channels.each do |chn|
      active_channels.push(chn) if chn['installed'] && chn['opt_in']
    end
    return active_channels
  end

  def ua_remove_tag
    if @tag_group_name === "subscriptions"
      return "You cannot remove tags from this tag group"
    else
      named_user_tags = UA::NamedUserTags.new(client: @airship)
      named_user_ids = [@named_user]
      named_user_tags.set_audience(user_ids: named_user_ids)
      named_user_tags.remove(group_name: @tag_group_name, tags: @name)
      named_user_tags.send_request
    end
  end
end