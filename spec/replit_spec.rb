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
      @client = Replit::Database::Client.new
    end

    it "will not work" do
      expect(@client.get("dummy")).to be_nil
    end
  end
end
