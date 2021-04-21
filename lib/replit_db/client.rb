require 'net/http'
require 'uri'
require 'json'
module ReplitDb
  class Client

    def initialize(custom_url = nil)
      @database_url = custom_url ||= ENV['REPLIT_DB_URL']
    end

    def get(key, options = {raw: false})
      raw_value = Net::HTTP.get(URI("#{@database_url}/#{key}"))
      return nil if raw_value.empty?
      return raw_value if options[:raw]
      value = json_parse raw_value
      throw ReplitDb::SyntaxError "Failed to parse value of #{key}, try passing a raw option to get the raw value" if value.nil?
      value
    end

    def set(key, value)
      Net::HTTP.post(URI(@database_url), "#{URI.encode(key)}=#{URI.encode(value)}")
    end

    def delete(key)
      Net::HTTP.delete(URI("#{@database_url}/#{key}"))
    end

    def list(prefix = '')

    end

    def empty

    end

    def get_all

    end

    def set_all(db_hash)

    end

    def delete_multiple(keys)

    end

    private

    def json_parse(string)
      JSON.parse(string, {symbolize_names: true})
    rescue JSON::ParserError
      nil
    end

  end
end
