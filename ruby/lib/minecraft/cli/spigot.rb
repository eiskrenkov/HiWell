# frozen_string_literal: true

module Minecraft
  module CLI
    class Spigot < Minecraft::CLI::Base
      option :version, required: true
      option :destination, required: true
      desc 'download_spigot_build_tools --version 1.17 --destination /downloads',
           'Validate Minecraft version and download Spigot build tools'
      def download_spigot_build_tools
        fetch_minecraft_version!(options[:version])

        download_file(Configuration.minecraft.spigot.build_tools_url, options[:destination])
      end

      option :destination, required: true
      desc 'download_spigot_plugins --destination /downloads/plugins',
           'Validate Minecraft version and download Spigot build tools'
      def download_spigot_plugins
        Minecraft::Plugins::Downloader.new(Configuration.minecraft.spigot.plugins.to_h, options[:destination]).call
      end
    end
  end
end
