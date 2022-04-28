# frozen_string_literal: true

module Api
  module V1
    #
    # Main Pets controller class
    #
    class PetsController < ApiController
      def index
        data, meta = paginate_resources Pet.all
        render_response(data: data, status_code: :ok, serializer: PetSerializer, meta: meta)
      end

      def show
        data = Pet.find(params[:id])
        render_response(data: data, status_code: :ok, serializer: PetSerializer, meta: nil)
      end

      def create
        pet = Pet.new(pet_params)

        if pet.save
          render_error_response("Could not create record", :unprocessable_entity, 9)
        else
          render_response(data: pet, status_code: :ok, serializer: PetSerializer, meta: nil)
        end
      end

      private

      def pet_params
        params.require(:pet).permit(
          :name,
          :tag
        )
      end
    end
  end
end
