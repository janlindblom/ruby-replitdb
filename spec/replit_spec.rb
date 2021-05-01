# frozen_string_literal: true

require "replit"

RSpec.describe Replit do
  describe Replit::Database do
    it "has a version defined" do
      expect(Replit::Database::VERSION).not_to be_nil
    end
  end
end

RSpec.describe Replit::Database::Client do
  context "without a defined connection URL" do
    before :all do
      @client = Replit::Database::Client.new("")
    end

    it "will raise a ConfigurationError" do
      expect { @client.get("dummy") }.to raise_error Replit::Database::ConfigurationError
      expect { @client.set("dummy", "value") }.to raise_error Replit::Database::ConfigurationError
      expect { @client.delete("dummy") }.to raise_error Replit::Database::ConfigurationError
    end
  end
end
