require 'rails_helper'

RSpec.describe GetPopulations do
  subject(:populations) { described_class.new('90503') }
  describe '#populations' do
    before do
      expect(subject).to receive(:cbsa)
        .and_return('12345')
    end

    describe 'with MSA data' do
      before do
        expect(subject).to receive(:msa)
          .exactly(3).times
          .and_return(
            OpenStruct.new(
              msa: 'Los Angeles',
              pop2015: '4000000',
              pop2014: '3500000'
            )
          )
      end

      it 'returns the correct data' do
        expect(subject.populations).to eq(
          zip: '90503',
          cbsa: '12345',
          msa: 'Los Angeles',
          pop2015: '4000000',
          pop2014: '3500000'
        )
      end
    end

    describe 'without MSA data' do
      before do
        expect(subject).to receive(:msa)
          .exactly(3).times
          .and_return(
            OpenStruct.new(
              msa: nil,
              pop2015: nil,
              pop2014: nil
            )
          )
      end

      it 'returns nil MSA values' do
        expect(subject.populations).to eq(
          zip: '90503',
          cbsa: '12345',
          msa: nil,
          pop2015: nil,
          pop2014: nil
        )
      end
    end
  end
end
