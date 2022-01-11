# frozen_string_literal: true

require 'open_config'

require_relative 'core_ext/object'

require_relative 'network'
require_relative 'open_delegator'

require_relative 'minecraft/cli'
require_relative 'minecraft/version'
require_relative 'minecraft/plugins'
require_relative 'minecraft/backuper'

module Minecraft
  CONFIGURATION_FILE = 'configuration.yml'
  DEPLOY_CONFIGURATION_FILE = 'deploy.yml'

  class << self
    def configuration
      @configuration ||= OpenConfig::YAML.new(root: ruby_root, file: CONFIGURATION_FILE).minecraft
    end

    def deploy_configuration
      @deploy_configuration ||= OpenConfig::YAML.new(root: root, file: DEPLOY_CONFIGURATION_FILE)
    end

    private

    def root
      File.expand_path('../..', __dir__)
    end

    def ruby_root
      File.expand_path('..', __dir__)
    end
  end
end
