class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |exception|
    render json: { error: exception }, status: :unprocessable_entity
  end
end
