# frozen_string_literal: true

module Minecraft
  module CLI
    class Vanilla < Minecraft::CLI::Base
      option :version, required: true
      option :destination, required: true
      desc 'download_server --version 1.17 --destination /downloads',
           'Download Minecraft server for required version'
      def download_server
        minecraft_version = fetch_minecraft_version!(options[:version])

        server_file_url = minecraft_version.meta.server_file_url
        puts "Server URL - #{server_file_url}, downloading file..."

        download_file(server_file_url, options[:destination])
      end
    end
  end
end
