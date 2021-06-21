# frozen_string_literal: true

require 'uri'
require 'open-uri'
require 'fileutils'
require 'logger'

require_relative 'network/api_client'

module Network
  class Error < StandardError; end

  class << self
    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def download(url, destination, filename = nil)
      filename ||= url.split('/').last
      file_path = "#{destination}/#{filename}"

      case io = OpenURI.open_uri(url)
      when StringIO
        File.open(file_path, 'w') { |f| f.write(io.read) }
      when Tempfile
        io.close
        FileUtils.mv(io.path, file_path)
      end

      filename
    end
  end
end
