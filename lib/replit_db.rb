# frozen_string_literal: true

require_relative 'replit_db/version'
require_relative 'replit_db/client'

module ReplitDb
  class Error < StandardError; end
  class SyntaxError < Error; end
end
