require 'faraday'

class Cloverly
  attr_reader :api_key

  class Error < StandardError; end

  def initialize(api_key)
    @api_key = api_key
  end

  def account
    conn = Faraday.new(:url => 'https://api.cloverly.app')
    conn.post do |req|
      req.url '/2019-03-beta/purchases/vehicle'
      req.body = '{"distance":{"value":55,"units":"km"},"fuel_efficiency":{"value":25,"units":"mpg","of":"gasoline"}}'
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{api_key}"
    end
  end
end
