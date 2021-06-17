# frozen_string_literal: true

require 'thor'

module Minecraft
  class CLI < Thor
    option :version, required: true
    option :destination, required: true
    desc 'download_server [VERSION]', 'Download Minecraft server for required version'
    def download_server
      minecraft_version = Minecraft::Version.new(options[:version])

      unless minecraft_version.meta
        abort "Can't find Minecraft version #{options[:version]}. " \
              "Known versions: #{Minecraft::Version::Manifest.instance.known_versions.join(', ')}"
      end

      server_file_url = minecraft_version.meta.server_file_url
      puts "Server URL - #{server_file_url}, downloading file..."

      filename = Network.download(server_file_url, options[:destination])
      puts "#{filename} download complete!"
    end
  end
end
