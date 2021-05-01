# frozen_string_literal: true

require_relative "database/client"

module Replit
  #
  # Replit Database module.
  #
  # @author Jan Lindblom <janlindblom@fastmail.fm>
  # @version 0.1.0
  #
  module Database
    #
    # Thrown if there is a syntax error.
    #
    class SyntaxError < StandardError; end

    #
    # Thrown if there is a configuration error.
    #
    class ConfigurationError < StandardError; end
  end
end
