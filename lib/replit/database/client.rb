# frozen_string_literal: true

require "net/http"
require "uri"
require "json"
require "cgi"

module Replit
  module Database
    #
    # The Replit Database Client.
    #
    class Client
      #
      # Create a new ReplitDb::Client.
      #
      # @param [String] custom_url optional custom URL
      #
      def initialize(custom_url = nil)
        @database_url = ENV["REPLIT_DB_URL"] if ENV["REPLIT_DB_URL"]
        @database_url = custom_url if custom_url
      end

      #
      # Gets a key.
      #
      # @param [String, Symbol] key Key.
      # @param [Hash] options Options Hash.
      # @option options [Boolean] :raw Makes it so that we return the raw string value. Default is false.
      #
      # @return [String,Object] the stored value.
      #
      def get(key, options = { raw: false })
        verify_connection_url

        raw_value = Net::HTTP.get(URI("#{@database_url}/#{key}"))
        return nil if raw_value.empty?
        return raw_value if options[:raw]

        json_parse(raw_value, key)
      end

      #
      # Sets a key.
      #
      # @param [String, Symbol] key Key.
      # @param [Object] value Value.
      # @param [Hash] options Options Hash.
      # @option options [Boolean] :raw Makes it so that we store the raw string value. Default is false.
      #
      def set(key, value, options = { raw: false })
        verify_connection_url

        json_value = options[:raw] ? value : value.to_json
        payload = "#{CGI.escape(key.to_s)}=#{CGI.escape(json_value)}"
        Net::HTTP.post(URI(@database_url), payload)
      end

      #
      # Deletes a key.
      #
      # @param [String] key Key.
      #
      def delete(key)
        verify_connection_url

        Net::HTTP.delete(URI("#{@database_url}/#{key}"))
      end

      #
      # List key starting with a prefix or list all.
      #
      # @param [String] prefix Filter keys starting with prefix.
      #
      # @return [Array<String>] keys in database.
      #
      def list(prefix = "")
        verify_connection_url

        response =
          Net::HTTP.get(
            URI("#{@database_url}?encode=true&prefix=#{CGI.escape(prefix)}")
          )
        return [] if response.empty?

        response.split("\n").map { |l| CGI.unescape(l) }
      end

      #
      # Clears the database.
      #
      def empty
        verify_connection_url

        list.each { |key| delete key }
      end

      #
      # Get all key/value pairs and return as an object.
      #
      # @return [Hash<String, Object>] Hash with all objects in database.
      #
      def get_all
        verify_connection_url

        output = {}
        list.each { |key| output[key.to_sym] = get key }
        output
      end

      #
      # Sets the entire database through an object.
      #
      # @param [Hash] obj The object.
      #
      def set_all(obj = {})
        verify_connection_url

        obj.each_key { |key| set(key, obj[key]) }
      end

      #
      # Delete multiple entries by keys
      #
      # @param [Array<String>] keys Keys.
      #
      def delete_multiple(keys = [])
        verify_connection_url

        keys.each { |key| delete key }
      end

      private

      def verify_connection_url
        error = Replit::Database::ConfigurationError.new "Missing database connection url"
        raise error unless @database_url
        raise error if @database_url.empty?
      end

      def json_parse(string, key)
        JSON.parse(string, { symbolize_names: true })
      rescue JSON::ParserError
        raise Replit::Database::SyntaxError, "Failed to parse value of #{
          key
        }, try passing a raw option to get the raw value"
      end
    end
  end
end
