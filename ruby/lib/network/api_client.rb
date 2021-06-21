# frozen_string_literal: true

require 'delegate'

require_relative 'api_client/base'
require_relative 'api_client/mojang'
require_relative 'api_client/spigot'
require_relative 'api_client/spiget'

module Network
  module APIClient
    class Error < StandardError; end

    class Response < SimpleDelegator
      alias response __getobj__

      def body_hash
        @body_hash ||= body.present? ? JSON.parse(response.body, symbolize_names: true) : {}
      end

      def successful?
        (200..299).include?(response.status)
      end
    end
  end
end
