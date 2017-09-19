class Push
  attr_accessor :message, :channel_id, :device_type, :title

  def initialize
    @ua_key = ENV['ua_key']
    @ua_master_secret = ENV['ua_master_secret']
    @uri = URI.parse("https://go.urbanairship.com/api/push")
    @accept = "application/vnd.urbanairship+json; version=3"
    @content_type = "application/json"
  end

  def push_message_to_channel
    if @device_type == "ios"
      channel_key = "ios_channel"
    elsif @device_type == "android"
      channel_key = "android_channel"
    else
      channel_key = "channel"
    end 
    
    data = {
      'audience' => {
        channel_key => @channel_id
      },
      'notification' => {
        'alert' => @message,
        'web' => {
          'title' => @title ? @title : ''
        }
      },
      'device_types' => [@device_type]
    }    

    header = {}
    header['Accept'] = @accept
    header['Content-Type'] = @content_type

    req = Net::HTTP::Post.new(@uri.request_uri, header)
    req.basic_auth @ua_key, @ua_master_secret
    req.body = data.to_json

    res = Net::HTTP.start(@uri.host, @uri.port, 
        :use_ssl => @uri.scheme == 'https') {|http| http.request req}

    return JSON.parse(res.body)
  end
end