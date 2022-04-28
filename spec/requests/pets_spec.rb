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

  def error_response_attributes
    %i[message code]
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
            { "id" => 17,
            "name" => "pet_test_1",
            "tag" => "pet_tag_1" }
          ],
          "meta" => {
            "total_pages" => 10,
            "page_number" => 1,
            "max_per_page" => 1,
            "total_resources" => 10
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
            "id" => 17,
            "name" => "pet_test_1",
            "tag" => "pet_tag_1"
          },
          "meta" => nil
        }

        run_test! do |response|
          pet_data = json_response[:data]

          expect(response).to have_http_status(:ok)
          expect(pet_data).to contain_attributes(pet_response_attributes)
        end
      end

      response 404, "Resource not found" do
        examples "application/json" => {
          "message" => "Could not find resource",
          "code" => 4
        }

        let(:pet_id) { 0 }

        run_test! do |response|
          expect(response).to have_http_status(:not_found)
          expect(json_response).to contain_attributes(error_response_attributes)
          expect(json_response[:message]).to eq("Could not find resource")
        end
      end
    end
  end

  path "/api/v1/pets" do
    post("Create pet") do
      tags "Pets"
      produces "application/json"
      consumes "application/json"

      let(:params) do
        { pet: { name: name, tag: tag } }
      end

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          pet: {
            type: :object,
            properties: {
              name: { type: :string, example: "my pet" },
              tag: { type: :string, example: "dog" }
            },
            required: %w[name]
          }
        },
        required: %w[pet]
      }

      let(:name) { "my pet" }
      let(:tag) { "dog" }

      response 200, "Creates a single pet" do
        examples "application/json" =>
        {
          "data" => {
            "id" => 1,
            "name" => "my pet",
            "tag" => "dog"
          },
          "meta" => nil
        }

        run_test! do |response|
          pet_data = json_response[:data]

          expect(response).to have_http_status(:ok)
          expect(pet_data).to contain_attributes(pet_response_attributes)
        end
      end

      response 422, "Invalid parameters" do
        examples "application/json" => {
          "message" => "Could not create record",
          "code" => 9
        }

        let(:name) { nil }

        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response[:message]).to eq("Could not create record")
          expect(json_response).to contain_attributes(error_response_attributes)
        end
      end
    end
  end
end
