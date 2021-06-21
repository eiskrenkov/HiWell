# frozen_string_literal: true

module Minecraft
  module Plugins
    class Downloader
      PLUGINS_EXTENSION = 'jar'

      class Error < StandardError; end

      attr_reader :plugins, :destination

      def initialize(plugins, destination)
        @plugins = plugins
        @destination = destination
      end

      def call
        plugins.each do |name, version|
          resource = find_resource(name)
          raise Error, "Couldn't find #{name} plugin" unless resource

          version = find_version(resource.id, version)
          raise Error, "Couldn't find #{name} v#{version}" unless version

          unless resource.version.fetch(:uuid) == version.uuid
            raise Error, "Version #{version} doesn't have external URL"
          end

          download(name, resource.id)
        end
      end

      private

      def find_resource(name)
        Minecraft::Plugins::Finders::Resource.new(name: name).call
      end

      def find_version(resource_id, version_name)
        Minecraft::Plugins::Finders::Version.new(resource_id: resource_id, name: version_name).call
      end

      def download(resource_name, resource_id)
        Network.download(build_download_url(resource_id), destination, build_resource_filename(resource_name))
      end

      def build_download_url(resource_id)
        "#{Configuration.minecraft.spigot.spiget.api_host}/resources/#{resource_id}/download"
      end

      def build_resource_filename(resource_name)
        "#{resource_name}.#{PLUGINS_EXTENSION}"
      end
    end
  end
end
