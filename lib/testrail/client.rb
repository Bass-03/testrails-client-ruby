require "testrail/client/version"
require 'net/http'
require 'net/https'
require 'uri'
require 'json'

# @author Edmundo Sanchez
module Testrail
  # Client for the TestRail API, both request based and idiomatic
  module Client
    # Net:HTTP based interface for the Testrail API
    # @attr url [String] Your Test rail URL
    # @attr user [String] Your testrail user
    # @attr password [String] Your testrail password
    class Request
      attr_accessor :url
      attr_accessor :user
      attr_accessor :password
      # Initialize Client
      # @param base_url [String] Your Testrail URL
      def initialize(base_url)
        if !base_url.match(/\/$/)
          base_url += '/'
        end
        @url = base_url + 'index.php?/api/v2/'
        @content_type = "application/json"
      end
      # send GET to uri
      # @param uri [String] Test rail API path
      # @return [Hash] Response from testrail API
      def send_get(uri)
         request = _setup_request("GET",uri)
        _send_request(request)
      end
      # send POST to uri
      # @param uri [String] test rail API path
      # @param data [Enumerable] data to be sent in the POST request
      # @return [Hash] Response from testrail API
      def send_post(uri, data = nil)
        request = _setup_request('POST', uri, data)
        _send_request(request)
      end

      private
      # Setup NET::HTTP request object
      # @param method [String] can be POST, GET, PUT, PATCH, or DELETE
      # @param uri [String] test rail API path
      # @param data [Enumerable] data to be sent in request
      # @return [Net::HTTPRequest] Request object
      def _setup_request(method,uri,data = nil)
        url = URI.parse(@url + uri)
        STDERR.puts "#{method} #{url}"
        http_request = eval("Net::HTTP::#{method.capitalize}")
        request = http_request.new(url)
        request.add_field('Content-Type', @content_type)
        request.body = JSON.dump(data) if data.is_a? Hash
        request.set_form data, 'multipart/form-data' if data.is_a? Array
        request.basic_auth(@user, @password)
        return request
      end

      # Returns response from API
      # @param request [Net::HTTPRequest] Request object created on _setup_request
      # @return [Hash] Response from API
      def _send_request(request)
        conn = Net::HTTP.new(request.uri.host, request.uri.port)
        if request.uri.scheme == 'https'
          conn.use_ssl = true
          conn.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        response = conn.request(request)

        if response.body && !response.body.empty?
          begin
            result = JSON.parse(response.body)
          rescue
            raise APIError.new("Can't parse response \n" + response.body)
          end
        else
          result = {}
        end
        if response.code != '200'
          if result && result.key?('error')
            error = '"' + result['error'] + '"'
          else
            error = 'No additional error message received'
          end
          raise APIError.new('TestRail API returned HTTP %s (%s)' %
            [response.code, error])
        end
        result
      end
    end

    # Custom Error class
    class APIError < StandardError; end

  end
end
