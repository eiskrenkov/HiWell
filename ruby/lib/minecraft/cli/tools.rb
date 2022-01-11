# frozen_string_literal: true

module Minecraft
  module CLI
    class Tools < Minecraft::CLI::Base
      desc 'latest_version', 'Prints the latest available Minecraft version'
      def latest_version
        puts "Latest Vanilla Minecraft version is #{Minecraft::Version.latest.data.fetch(:id)}"
      end

      option :stage, required: true
      option :destination, required: true
      desc 'backup --stage production --destination ~/Desktop/hiwell_backups',
           'Downloads latest world, world_nether, world_the_end and usercache.json from the server'
      def backup
        Minecraft::Backuper.new(options[:stage], options[:destination]).call
      end
    end
  end
end
