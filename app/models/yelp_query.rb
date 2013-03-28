class YelpQuery
   def initialize
    @consumer        = build_consumer
    @access_token    = build_access_token
  end

  def fetch!(criteria)
    JSON.parse(@access_token.get(path(criteria)).body)
  end

  private
  def path(criteria)
    "/v2/search?term=#{safe(criteria["destination"])}&location=#{safe(criteria["address"])}"
  end

  def build_consumer
    OAuth::Consumer.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'], {:site => "http://api.yelp.com"} )
  end

  def build_access_token
    OAuth::AccessToken.new(@consumer, ENV['TOKEN'], ENV['TOKEN_SECRET'])
  end

  def safe(str)
    CGI::escape(str)
  end
end
