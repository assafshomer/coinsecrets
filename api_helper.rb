require 'open-uri'
require 'net/http'

class ApiCaller
	attr_reader :data, :response

	def initialize(url,https=true)
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = https
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
		get = http.get(uri.request_uri)
		@data = get.body
		@response = get.message 
	end



end