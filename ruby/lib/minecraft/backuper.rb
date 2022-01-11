# frozen_string_literal: true

require 'net/scp'

module Minecraft
  class Backuper
    attr_reader :stage, :destination

    def initialize(stage, destination)
      @stage = stage
      @destination = destination
    end

    def call
      puts "Downloading files from #{volume_path} at #{configuration.host} to #{destination}..."

      download!
      rename!

      puts 'Done!'
    end

    private

    def download!
      Net::SCP.download!(configuration.host, configuration.user, volume_path, destination, recursive: true)
    end

    def rename!
      downloaded_folder_path = File.join(destination, volume_path.split('/').last)
      new_folder_path = File.join(destination, "backup_#{Time.now.utc.strftime('%d_%m_%Y')}")

      FileUtils.mv(downloaded_folder_path, new_folder_path)
    end

    def volume_path
      Minecraft.configuration.volume_path
    end

    def configuration
      Minecraft.deploy_configuration.stages.send(stage)
    end
  end
end
