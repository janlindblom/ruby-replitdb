# frozen_string_literal: true

require_relative "replit_db/version"
require_relative "replit_db/client"

#
# The Replit Database module.
#
# @author Jan Lindblom <janlindblom@fastmail.fm>
#
module ReplitDb
  #
  # Thrown if there is a syntax error.
  #
  class SyntaxError < StandardError; end
end
