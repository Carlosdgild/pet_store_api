# frozen_string_literal: true

#
# Main API class wrapper
#
class ApiController < ApplicationController
  rescue_from(TypeError) { |error| handle_type_error_error(error) }
  rescue_from(ArgumentError) { |error| handle_argument_error(error) }
  rescue_from(ActiveRecord::RecordNotFound) { |error| handle_active_record_not_found_error(error) }
  rescue_from(ActiveRecord::RecordInvalid) { |error| render_record_not_valid_error(error) }
  rescue_from(ActiveRecord::RecordNotUnique) { |error| handle_active_record_not_unique_error(error) }
  rescue_from(ActiveRecord::StatementInvalid) { |error| handle_active_record_statement_invalid_error(error) }
  rescue_from(ActionController::ParameterMissing) { |error| handle_action_controller_parameter_missing_error(error) }
  rescue_from(ActionController::RoutingError) { |error| handle_action_controller_routing_error(error) }
  rescue_from(ActiveModel::ForbiddenAttributesError) { |error| handle_active_model_forbidden_attributes_error(error) }

  #
  # Raises no route
  #
  # @return [ActionController::RoutingError]
  def raise_no_matching_route!
    raise ActionController::RoutingError, "Route does not match #{request&.request_method} '/#{params[:unmatched_route_error]}'"
  end

  private

  def render_error_response(message = "An error has occurred", status_code = :bad_request, type = "error", errors = [])
    render json: {
      message: message,
      type: type,
      errors: errors
    }, status: status_code
  end

  def handle_file_upload_error(error)
    logger.error(error&.message)

    render_error_response(error&.message, :unprocessable_entity, "file error")
  end

  def handle_argument_error(error)
    logger.error(error&.message)

    render_error_response(error&.message, :bad_request, "argument_error")
  end

  def handle_type_error_error(error)
    logger.error(error&.message)

    render_error_response(error&.message, :bad_request, "type_error")
  end

  def handle_active_record_not_found_error(error)
    logger.error(error&.message)

    render_error_response("Couldn't find resource", :not_found, "not_found_error")
  end

  def handle_active_record_statement_invalid_error(error)
    logger.error(error&.message)

    render_error_response("Invalid statement in field", :unprocessable_entity, "invalid_statement_error")
  end

  def handle_active_model_forbidden_attributes_error(error)
    logger.error(error&.message)

    render_error_response("Forbidden attributes in record", :unprocessable_entity, "forbidden_attribute_error")
  end

  def handle_action_controller_parameter_missing_error(error)
    logger.error("Missing parameter #{error&.param}")

    render_error_response("Missing parameter #{error&.param}", :bad_request, "parameter_missing_error")
  end

  def handle_action_controller_routing_error(error)
    logger.error(error&.message)

    render_error_response(error&.message, :bad_request, "routing_error")
  end

  def handle_active_record_not_unique_error(error)
    logger.error(error&.message)

    render_error_response("A record already exists", :bad_request, "not_unique_error")
  end

  def render_record_not_valid_error(error)
    logger.error(error&.message)

    render_error_response(error&.message, :unprocessable_entity, "invalid_error", error.record&.errors&.messages)
  end
end
