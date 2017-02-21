class Channel
  attr_accessor :tag_name, :id, :tag_group_name
  
  def initialize
    @airship = UA::Client.new(key: ENV['ua_key'], secret: ENV['ua_master_secret'])
  end

  def ua_get_channel_info  
    channel_client = UA::ChannelInfo.new(client: @airship)
    channel_info = channel_client.lookup(uuid: @id)
    return channel_info
  end

  def ua_channel_add_tag
    if @tag_group_name === "subscriptions"
      return "You cannot add tags on this tag group"
    else
      channel_tags = UA::ChannelTags.new(client: @airship)
      channel_client = UA::ChannelInfo.new(client: @airship)
      channel_info = channel_client.lookup(uuid: @id)
      platform = channel_info["device_type"]

      case platform
      when "ios"
        channel_tags.set_audience(ios: @id)        
      when "android"
        channel_tags.set_audience(android: @id)
      end
      
      channel_tags.add(group_name: @tag_group_name, tags: [@tag_name])
      channel_tags.send_request
    end
  end
  
  def ua_channel_has_tag
    channel_client = UA::ChannelInfo.new(client: @airship)

    begin
      channel_info = channel_client.lookup(uuid: @id)
      tags = channel_info['tag_groups'][@tag_group_name]
      if !tags 
        tags = []
      end
    rescue
      tags = []
    end
    return tags.include? @tag_name
  end

  def ua_remove_tag
    if @tag_group_name === "subscriptions"
      return "You cannot remove tags from this tag group"
    else
      channel_tags = UA::ChannelTags.new(client: @airship)
      channel_client = UA::ChannelInfo.new(client: @airship)
      channel_info = channel_client.lookup(uuid: @id)
      platform = channel_info["device_type"]

      case platform
      when "ios"
        channel_tags.set_audience(ios: @id)        
      when "android"
        channel_tags.set_audience(android: @id)
      end
      
      channel_tags.remove(group_name: @tag_group_name, tags: [@tag_name])
      channel_tags.send_request
    end
  end
end