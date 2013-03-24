class YelpQuery
   def initialize
    @consumer        = build_consumer
    @access_token    = build_access_token
  end

  def fetch!(criteria)
    data = @access_token.get(path(criteria)).body
    JSON.parse(data)["businesses"].first(5)
  end

  private
  def path(criteria)
    "/v2/search?term=#{safe(criteria["term"])}&location=#{safe(criteria["location"])}"
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
