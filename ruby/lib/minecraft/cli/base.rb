# frozen_string_literal: true

module Minecraft
  module CLI
    class Base < Thor
      private

      def fetch_minecraft_version!(version)
        minecraft_version = Minecraft::Version.new(version)
        return minecraft_version if minecraft_version.meta

        abort "Can't find Minecraft version #{options[:version]}. " \
              "Known versions: #{Minecraft::Version::Manifest.instance.known_versions.join(', ')}"
      end

      def download_file(url, destination)
        filename = Network.download(url, destination)
        puts "#{filename} download complete!"
      end
    end
  end
end
