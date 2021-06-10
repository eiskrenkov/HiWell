# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

module Network
  class APIClient
    def self.get(url)
      response = Network.request(:get_response, url)
      return {} unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body, symbolize_names: true)
    end
  end

  class << self
    def download(url)
      url.split('/').last.tap do |filename|
        File.write(filename, request(:get, url))
      end
    end

    def request(verb, url)
      Net::HTTP.public_send(verb, URI(url))
    end
  end
end
