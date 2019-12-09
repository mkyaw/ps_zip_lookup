require 'rails_helper'

RSpec.describe FindMsaByCbsa do
  subject(:finder) { described_class.new(cbsa) }
  describe '#get_msa' do
    let(:csv_rows) do
      CSV.new(file_fixture("cbsa_to_msa.csv").read, headers: true)
    end

    describe 'with MSA data' do
      before do
        expect(subject).to receive(:msa_rows)
          .and_return(csv_rows)
      end

      describe 'with matching CBSA value' do
        let(:cbsa) { 31080 }
        it 'returns the correct row' do
          expect(subject.get_msa).to eq(
            OpenStruct.new(
              msa: 'Los Angeles-Long Beach-Glendale, CA',
              pop2015: '10170292',
              pop2014: '10109436'
            )
          )
        end
      end

      describe 'with matching MDIV value' do
        let(:cbsa) { 35614 }
        it 'returns the correct row' do
          expect(subject.get_msa).to eq(
            OpenStruct.new(
              msa: 'New York-Jersey City-White Plains, NY-NJ',
              pop2015: '14413079',
              pop2014: '14331539'
            )
          )
        end
      end
    end

    describe 'without CBSA value' do
      let(:cbsa) { nil }
      it 'returns nil for all the fields' do
        expect(subject).to_not receive(:msa_rows)

        expect(subject.get_msa).to eq(
          OpenStruct.new(
            msa: nil,
            pop2015: nil,
            pop2014: nil
          )
        )
      end
    end
  end
end
