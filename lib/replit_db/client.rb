require 'net/http'

module ReplitDb
  class Client

    def initialize(custom_url = nil)
      @database_url = custom_url ||= ENV['REPLIT_DB_URL']
    end

    def get(key, options = {raw: false})
      Net::HTTP.get("#{@database_url}/#{key}")
    end

    def set(key, value)

    end

    def delete(key)

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
  end
end
