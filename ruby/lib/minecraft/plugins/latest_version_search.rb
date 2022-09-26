# frozen_string_literal: true

module Minecraft
  module Plugins
    class LatestVersionSearch
      class Error < StandardError; end

      attr_reader :name

      def initialize(name)
        @name = name
      end

      def call
        resource = find_resource
        raise Error, "Couldn't find #{name} plugin" unless resource

        versions = list_versions(resource.id)
        raise "Can't list versions for #{resource}" if versions.blank?

        latest_version = Minecraft::Plugins::Version.new(versions.first)
        puts "Latest version of #{resource.name} is #{latest_version.name} " \
             "(uuid: #{latest_version.uuid}, id: #{latest_version.id})"
      end

      private

      def find_resource
        Minecraft::Plugins::Finders::Resource.new(name: name).call
      end

      def list_versions(resource_id)
        Network::APIClient::Spiget.instance.resource_versions(resource_id)
      end
    end
  end
end
