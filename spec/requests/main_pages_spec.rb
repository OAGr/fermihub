require 'spec_helper'

describe "MainPages" do
  describe "GET /home" do
    it "works!" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get root_path
      response.status.should be(200)
    end
  end
end
