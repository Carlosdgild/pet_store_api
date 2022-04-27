# frozen_string_literal: true

require "rails_helper"

RSpec.describe "API base controller", type: :request do
  describe "Routing", type: :routing do
    it "routes to raise_no_matching_route!" do
      { get: "/invalid_route" }.should
        route_to(controller: "api", action: "raise_no_matching_route!")
    end
  end

  describe "GET /invalid_route" do
    it "returns bad request" do
      get "/invalid_route"

      expect(response).to have_http_status(:bad_request)
      expect(json_response[:message]).to eq("Route does not match GET '/invalid_route'")
    end
  end
end
