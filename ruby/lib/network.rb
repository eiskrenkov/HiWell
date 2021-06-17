# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

module Network
  class Error < StandardError; end

  class APIClient
    def self.get(url)
      response = Network.request(:get_response, url)
      return JSON.parse(response.body, symbolize_names: true) if response.is_a?(Net::HTTPSuccess)

      raise(Network::Error, "#{verb.to_s.split('_').first.upcase} #{url} failed with status #{response.code}")
    end
  end

  class << self
    def download(url, destination)
      url.split('/').last.tap do |filename|
        File.write("#{destination}/#{filename}", request(:get, url))
      end
    end

    def request(verb, url)
      Net::HTTP.public_send(verb, URI(url))
    end
  end
end
