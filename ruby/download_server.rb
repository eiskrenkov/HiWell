# frozen_string_literal: true

require_relative 'lib/minecraft'
require_relative 'lib/network'

server_url = Minecraft::Version.new(ARGV[0]).downloads.server_url
puts "Server URL - #{server_url}, downloading file..."

filename = Network.download(server_url)
puts "#{filename} download complete!"
