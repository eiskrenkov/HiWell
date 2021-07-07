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
           'Validate Minecraft version and download Spigot build tools'
      def download_plugins
        Minecraft::Plugins::Downloader.new(Minecraft.configuration.spigot.plugins.to_h, options[:destination]).call
      end
    end
  end
end
