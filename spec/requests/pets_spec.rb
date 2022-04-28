# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Pets API", type: :request do
  describe "Routing", type: :routing do
    it "routes to index" do
      { get: "/api/v1/pets" }.should
        route_to(controller: "api/v1/pets", action: "index")
    end

    it "routes to show" do
      { get: "/api/v1/pets/1" }.should
        route_to(controller: "api/v1/pets", action: "show", id: 1)
    end

    it "routes to create" do
      { post: "/api/v1/pets/1" }.should
        route_to(controller: "api/v1/pets", action: "create", id: 1)
    end
  end
end
