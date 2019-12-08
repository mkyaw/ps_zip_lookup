class PopulationsController < ApplicationController
  def index
    populations = GetPopulations.call(zip: zip)
    render json: populations
  end

  private

  def zip
    params.require('zip')
  end
end
