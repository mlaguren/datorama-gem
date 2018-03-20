module Datorama
  class Api
    BASE_PATH = 'https://app.datorama.com/services'

    def initialize(username, password)
      @username = username
      @password = password
    end

    def authenticate
      url = BASE_PATH+"/auth/authenticate"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      request.body = {:email=>@username, :password => @password}.to_json
      response = http.request(request)
      JSON.parse(response.body)['token']
    end

    def single_query(token, query)
      url = BASE_PATH+"/query/execQuery"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      request['token'] = token
      request.body = query.to_json
      http.request(request)
    end

  end
end
