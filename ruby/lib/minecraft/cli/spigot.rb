# frozen_string_literal: true

module Minecraft
  module CLI
    class Spigot < Minecraft::CLI::Base
      option :version, required: true
      option :destination, required: true
      desc 'download_build_tools --version 1.17 --destination /downloads',
           'Validate Minecraft version and download Spigot build tools'
      def download_build_tools
        fetch_minecraft_version!(options[:version])

        download_file(Minecraft.configuration.spigot.build_tools_url, options[:destination])
      end

      option :destination, required: true
      desc 'download_plugins --destination /downloads/plugins',
           'Download plugins configured in configuration.yml'
      def download_plugins
        Minecraft::Plugins::Downloader.new(Minecraft.configuration.spigot.plugins.to_h, options[:destination]).call
      end

      option :name, required: true
      desc 'find_latest_plugin_version --name skisrestorer',
           'Find latest plugin version'
      def find_latest_plugin_version
        Minecraft::Plugins::LatestVersionSearch.new(options[:name]).call
      end
    end
  end
end
