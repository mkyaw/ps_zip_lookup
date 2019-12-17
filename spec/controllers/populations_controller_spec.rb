require 'rails_helper'

RSpec.describe PopulationsController, type: :controller do

  describe 'GET #index' do
    describe 'successful call' do
      let(:populations) do
        {
          zip: '12345',
          cbsa: '3111',
          msa: 'Los Angeles-Long Beach-Glendale, CA',
          pop2015: '10170292',
          pop2014: '10109436'
        }
      end

      before do
        expect(GetPopulations).to receive(:call)
          .and_return(populations)
      end

      it 'returns http success' do
        get :index, params: { zip: '12345' }
        expect(response).to have_http_status(:success)
      end

      it 'returns correct data' do
        get :index, params: { zip: '12345' }
        expect(JSON.parse(response.body)).to eq(
          'zip' => '12345',
          'cbsa' => '3111',
          'msa' => 'Los Angeles-Long Beach-Glendale, CA',
          'pop2015' => '10170292',
          'pop2014' => '10109436'
        )
      end
    end

    describe 'missing parameter' do
      it 'returns the error' do
        get :index
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq(
          'error' => 'param is missing or the value is empty: zip'
        )
      end
    end
  end
end
