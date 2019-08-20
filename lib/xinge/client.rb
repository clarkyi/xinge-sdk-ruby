require 'http/net'

class Xinge::Client
  class << self
    def do_post url, data, sign_auth
      url = URI(url)
      http = Net::HTTP.new(url.host, url.port)
      header = {'content-type' => 'application/json'}
      response = http.post(url, data, headers(sign_auth))
      response
    end

    private
      def self.headers sign_auth
        {Authorization: "Basic #{sign_auth}"}
      end
  end
end