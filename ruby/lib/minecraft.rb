# frozen_string_literal: true

require 'open_config'

require_relative 'core_ext/object'

require_relative 'network'
require_relative 'open_delegator'

require_relative 'minecraft/cli'
require_relative 'minecraft/version'
require_relative 'minecraft/plugins'

module Minecraft
  CONFIGURATION_FILE = 'configuration.yml'

  class << self
    def root
      File.expand_path('..', __dir__)
    end

    def configuration
      @configuration ||= OpenConfig::YAML.new(root: root, file: CONFIGURATION_FILE).minecraft
    end
  end
end
