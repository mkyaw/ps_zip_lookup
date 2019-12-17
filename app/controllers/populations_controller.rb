class PopulationsController < ApplicationController
  def index
    if valid_zip?(zip)
      populations = GetPopulations.call(zip: zip)
      render json: populations
    else
      render json: { error: 'invalid zip' }, status: :unprocessable_entity
    end
  end

  private

  def valid_zip?(zip)
    zip =~ /^\d{5}(-\d{4})?$/
  end

  def zip
    @zip ||= params.require('zip')
  end
end
