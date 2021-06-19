# frozen_string_literal: true

require 'thor'

module Minecraft
  class CLI < Thor
    option :version, required: true
    option :destination, required: true
    desc 'download_vanilla_server [VERSION]', 'Download Minecraft server for required version'
    def download_vanilla_server
      minecraft_version = fetch_minecraft_version!(options[:version])

      server_file_url = minecraft_version.meta.server_file_url
      puts "Server URL - #{server_file_url}, downloading file..."

      download_file(server_file_url, options[:destination])
    end

    option :version, required: true
    option :destination, required: true
    desc 'download_spigot_build_tools [VERSION]', 'Validate Minecraft version and download Spigot build tools'
    def download_spigot_build_tools
      fetch_minecraft_version!(options[:version])

      download_file(Configuration.minecraft.spigot.build_tools_url, options[:destination])
    end

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
