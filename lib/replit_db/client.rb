# frozen_string_literal: true

require "net/http"
require "uri"
require "json"
require "cgi"
module ReplitDb
  #
  # The ReplitDb Client.
  #
  class Client
    #
    # Create a new ReplitDb::Client.
    #
    # @param [String] custom_url optional custom URL
    #
    def initialize(custom_url = nil)
      @database_url = ENV["REPLIT_DB_URL"]
      @database_url = custom_url unless custom_url.nil?
    end

    #
    # Gets a key.
    #
    # @param [String] key Key.
    # @param [Hash] options Options Hash.
    # @option options [Boolean] :raw Makes it so that we return the raw string value. Default is false.
    #
    # @return [String,Object] the stored value.
    #
    def get(key, options = { raw: false })
      raw_value = Net::HTTP.get(URI("#{@database_url}/#{key}"))
      return nil if raw_value.empty?
      return raw_value if options[:raw]

      value = json_parse raw_value
      if value.nil?
        throw ReplitDb::SyntaxError "Failed to parse value of #{key}, try passing a raw option to get the raw value"
      end
      value
    end

    #
    # Sets a key.
    #
    # @param [String] key Key.
    # @param [Object] value Value.
    #
    def set(key, value)
      json_value = value.to_json
      payload = "#{CGI.escape(key)}=#{CGI.escape(json_value)}"
      Net::HTTP.post(URI(@database_url),
                     payload)
    end

    #
    # Deletes a key.
    #
    # @param [String] key Key.
    #
    def delete(key)
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
      response = Net::HTTP.get(URI("#{@database_url}?encode=true&prefix=#{CGI.escape(prefix)}"))
      return [] if response.empty?

      response.split('\n').map { |l| CGI.unescape(l) }
    end

    #
    # Clears the database.
    #
    def empty
      list.each do |key|
        delete key
      end
    end

    #
    # Get all key/value pairs and return as an object
    #
    # @return [Hash<String, Object>] Hash with all objects in database.
    #
    def get_all
      output = {}
      list.each do |key|
        output[key] = get key
      end
      output
    end

    #
    # Sets the entire database through an object.
    #
    # @param [Hash] obj The object.
    #
    def set_all(obj = {})
      obj.each_key do |key|
        set(key, obj[key])
      end
    end

    #
    # Delete multiple entries by keys
    #
    # @param [Array<String>] keys Keys.
    #
    def delete_multiple(keys = [])
      keys.each do |key|
        delete key
      end
    end

    private

    def json_parse(string)
      JSON.parse(string, { symbolize_names: true })
    rescue JSON::ParserError
      nil
    end
  end
end
