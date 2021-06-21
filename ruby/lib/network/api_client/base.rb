# frozen_string_literal: true

require 'singleton'
require 'json'

require 'faraday'
require 'faraday_middleware'

module Network
  module APIClient
    class Base
      include Singleton

      def get(endpoint, params = {})
        perform_request(:get, endpoint, params)
      end

      def post(endpoint, params = {})
        perform_request(:post, endpoint, params)
      end

      private

      def host
        # API client requires full URL by default
      end

      def perform_request(verb, endpoint, params)
        log_request(verb, endpoint, params)

        response = connection.send(verb, endpoint, params)
        handle_response(response)
      rescue StandardError => e
        logger.error("API error: #{e.message}")
        raise Network::APIClient::Error, e.message
      end

      def log_request(verb, endpoint, params)
        logger.info("Performing API request: #{verb.upcase} #{host}/#{endpoint} with params #{params.inspect}")
      end

      def handle_response(response)
        Network::APIClient::Response.new(response).tap do |r|
          logger.info("Response status is #{r.status}")
          logger.info("Response: #{r.body_hash.inspect}") if r.body.present?
        end
      end

      def handle_errrors(fallback_value)
        response = yield
        response.successful? ? response.body_hash : fallback_value
      end

      def logger
        Network.logger
      end

      def connection
        @connection ||= Faraday.new(host) do |connection|
          setup_connection(connection)
        end
      end

      def setup_connection(connection); end
    end
  end
end
