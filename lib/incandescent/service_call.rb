require 'digest'

module Incandescent
  class ServiceCall
    ENDPOINT = 'https://incandescent.xyz/'

    attr_reader :payload, :method_path, :connection

    def initialize(method_path, params)
      @connection = Faraday.new(url: ENDPOINT)
      @method_path = method_path

      expire_time = Time.now.to_i + 60*15

      @payload = {uid: ENV['INCANDESCENT_UID'],
                  auth: auth_token(expire_time),
                  expires: expire_time}
      @payload.merge!(params)
    end

    def results
      make_post_request(method_path, payload)
    end

    private

      def make_post_request(method, params)
        connection.post do |req|
          req.url "/api/#{method_path}/"
          req.headers['Content-Type'] = 'application/json'
          req.body = payload.to_json
        end
      end


      # MD5 hash of your uid, the expires parameter, and your API Key
      # $uid."-".$expires."-".$apikey;
      def auth_token(expire_time)
        Digest::MD5.hexdigest("#{ENV['INCANDESCENT_UID']}-#{expire_time}-#{ENV['INCANDESCENT_API_KEY']}")
      end
  end
end