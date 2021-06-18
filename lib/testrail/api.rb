require "testrail/client"
# @author Edmundo Sanchez
module Testrail
  module Client
    # Metaprogrammed class to provide an idiomatic interface to the testrails API
    class Api < Request
      private
      # Using Meta programming, catch all endpoints adn send a request to them
      # @param m [string] name of the missing method
      # @param args [Array] Arguments
      # @param block [Proc] Block
      def method_missing(m, *args, &block)
        x,y = *args
        id = x if x.is_a? Integer #if Integer it is an ID
        opts = x if x.is_a? Hash #if Hash it is an options array
        opts ||= y #if opts not set, take second arg
        begin
          case m
          when /get/
            send_get("#{m}/#{id}&#{_param_stringify(opts)}")
          when /add_attachment/
            send_post("#{m}/#{id}",opts.to_a)
          else
            send_post("#{m}/#{id}",opts)
          end
        rescue Testrail::Client::APIError => error
          time_to_wait = 60
          STDERR.puts("Hit Testrail\'s API rate Limits, Sleeing #{time_to_wait} seconds")
          sleep(time_to_wait)
          STDERR.puts("Retrying #{m} with #{args}")
          retry
        end
      end
      # Stringify parameters for GET requests
      # @param opts [Hash] parameters for the request
      # @return [String] Stringified parameters
      def _param_stringify(opts)
        opts.to_a.map { |x| "#{x[0]}=#{x[1]}" }.join("&")
      end
    end
  end
end
