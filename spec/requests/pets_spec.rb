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

  def pet_response_attributes
    %i[id name tag]
  end

  path "/api/v1/pets" do
    get("Get pets") do
      tags "Pets"
      produces "application/json"

      let!(:pets) { create_list(:pet, 10) }

      response 200, "Gets a list of pets" do
        examples "application/json" =>
        {
          "data" => [
            {"id"=>17,
            "name"=>"pet_test_1",
            "tag"=>"pet_tag_1"
            }
          ],
          "meta" => {
            "total_pages"=>10,
            "page_number"=>1,
            "max_per_page"=>1,
            "total_resources"=>10
          }
        }

        run_test! do |response|
          pet_data = json_response[:data].first

          expect(response).to have_http_status(:ok)
          expect(pet_data).to contain_attributes(pet_response_attributes)
        end
      end
    end
  end

  path "/api/v1/pets/{pet_id}" do
    get("Get pet") do
      tags "Pets"
      produces "application/json"

      parameter name: :pet_id, in: :path, type: :string, required: true, example: "1"

      let!(:pet) { create(:pet) }
      let(:pet_id) { pet.id }

      response 200, "Gets a single pet" do
        examples "application/json" =>
        {
          "data" => {
            "id"=>17,
            "name"=>"pet_test_1",
            "tag"=>"pet_tag_1"
          },
          "meta" => nil
        }

        run_test! do |response|
          pet_data = json_response[:data]

          expect(response).to have_http_status(:ok)
          expect(pet_data).to contain_attributes(pet_response_attributes)
        end
      end
    end
  end
end
