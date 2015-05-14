class TwitterClient Twitter::Rest::Client

	attr_reader :consumer_key, :consumer_secret, :access_token, :access_token_secret

	def initialize
	  @consumer_key        = "A" * 20
	  @consumer_secret     = "a" * 30
	  @access_token        = "a" * 30
	  @access_token_secret = "a" * 30
	end

end
