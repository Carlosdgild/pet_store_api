# frozen_string_literal: true

#
# Main Application Controller
#
class ApplicationController < ActionController::API
  include Pagination::Paginate
  include Rendering::RenderResponse
end
