# frozen_string_literal: true

module Rendering
  #
  # Wrapper for standarized responses
  #
  # :reek:DataClump
  # :reek:ManualDispatch
  module RenderResponse
    #
    # Renders resources
    #
    # @param [Any] data The data to return
    # @param [Symbol] status_code The HTTP status code to return
    # @param [ActiveModel::Serializer] serializer The serializer to use
    # @param [Hash] meta Extradata
    # @param [Hash] serializer_params Parameters to be passed to the serializer
    #
    # @return [void]
    def render_response(data: nil, status_code: :ok, serializer: nil, meta: nil, serializer_params: {})
      if status_code == :no_content
        render_no_content
        return
      end

      if serializer.present?
        if data.respond_to?(:each)
          render_multiple_response(data, status_code, serializer, meta, serializer_params)
        else
          render_single_response(data, status_code, serializer, meta, serializer_params)
        end
      else
        render_raw_response(data, status_code, meta)
      end
    end

    #
    # Serializes data
    #
    # @param [Any] data The data to serialize
    # @param [ActiveModel::Serializer] serializer The serializer to use
    # @param [Hash] serializer_params Parameters passed to the serializer
    #
    # @return [void]
    #
    # :nocov:
    def serialize_response(data: nil, serializer: nil, serializer_params: {})
      raise if serializer.blank?

      if data.respond_to?(:each)
        serialize_multiple_resources(data: data, serializer: serializer, serializer_params: serializer_params)
      else
        serialize_single_resource(data: data, serializer: serializer, serializer_params: serializer_params)
      end
    end
    # :nocov:

    private

    def render_no_content
      head :no_content
    end

    def render_raw_response(data, status_code, meta)
      render json: {
        data: data,
        meta: meta
      }, status: status_code
    end

    def serialize_multiple_resources(data: nil, serializer: nil, serializer_params: nil)
      ActiveModel::Serializer::CollectionSerializer.new(data, { serializer: serializer, serializer_params: serializer_params })
    end

    def serialize_single_resource(data: nil, serializer: nil, serializer_params: {})
      serializer.new(data, { serializer_params: serializer_params })
    end

    def render_multiple_response(data, status_code, serializer, meta, serializer_params)
      render json: {
        data: serialize_multiple_resources(data: data, serializer: serializer, serializer_params: serializer_params),
        meta: meta
      }, status: status_code
    end

    def render_single_response(data, status_code, serializer, meta, serializer_params)
      render json: {
        data: serialize_single_resource(data: data, serializer: serializer, serializer_params: serializer_params),
        meta: meta
      }, status: status_code
    end
  end
end
