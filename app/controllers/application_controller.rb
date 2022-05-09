class ApplicationController < ActionController::Base
  BAD_REQUEST_ERRORS = [
    BadCsvError,
    ActionController::ParameterMissing,
    ArgumentError,
    BadRecordUpdate
  ]

  BAD_REQUEST_ERRORS.each do |error|
    rescue_from error, with: :bad_request
  end

  private

  def bad_request(e)
    render json: {error: e.message}, status: :bad_request
  end
end
