# frozen_string_literal: true

module Minecraft
  class Version
    Downloads = Struct.new(:client_url, :server_url)

    class << self
      def latest
        new(manifest.dig(:latest, :release))
      end

      def manifest
        @manifest ||= Network::APIClient.get(manifest_uri)
      end

      private

      def manifest_uri
        URI(Configuration.minecraft.version_manifest_url)
      end
    end

    attr_reader :number

    def initialize(number)
      @number = number
    end

    def downloads
      data = meta.fetch(:downloads)
      Downloads.new(data.dig(:client, :url), data.dig(:server, :url))
    end

    private

    def meta
      @meta ||= Network::APIClient.get(info.fetch(:url))
    end

    def info
      self.class.manifest.fetch(:versions).find do |version|
        version.fetch(:id) == number
      end
    end
  end
end
