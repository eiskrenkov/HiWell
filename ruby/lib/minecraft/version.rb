# frozen_string_literal: true

require 'singleton'
require 'time'

module Minecraft
  class Version
    RELEASE_DATE_FORMAT = '%d.%m.%Y'

    class Manifest
      include Singleton

      def latest_version
        data.fetch(:latest).fetch(:release)
      end

      def known_versions
        versions_data.keys
      end

      def versions_data
        data.fetch(:versions).each_with_object({}) do |version_data, memo|
          memo[version_data.fetch(:id)] = version_data
        end
      end

      private

      def data
        @data ||= Network::APIClient.get(url)
      end

      def url
        URI(Configuration.minecraft.version_manifest_url)
      end
    end

    class Meta
      attr_reader :url

      def initialize(url)
        @url = url
      end

      def server_file_url
        fetch_download_url(:server)
      end

      def client_file_url
        fetch_download_url(:client)
      end

      private

      def fetch_download_url(unit)
        data.fetch(:downloads).fetch(unit).fetch(:url)
      end

      def data
        @data ||= Network::APIClient.get(url)
      end
    end

    def self.latest
      new(Manifest.instance.latest_version)
    end

    attr_reader :number, :data

    def initialize(number)
      @number = number
      @data = Manifest.instance.versions_data[number]
    end

    def meta
      Meta.new(data.fetch(:url)) if data
    end

    def release_date
      Time.parse(data.fetch(:releaseTime)).strftime(RELEASE_DATE_FORMAT) if data
    end
  end
end
