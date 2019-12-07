require 'rails_helper'

RSpec.describe FindCbsaByZip do
  subject(:finder) { described_class.new(zip) }
  describe '#fetch_cbsa_row' do
    let(:csv_rows) do
      CSV.new(file_fixture("zip_to_cbsa.csv").read, headers: true)
    end

    before do
      expect(subject).to receive(:cbsa_rows)
        .and_return(csv_rows)
    end

    describe 'valid zip' do
      let(:zip) { 623 }
      it 'returns the correct row' do
        expect(subject.fetch_cbsa_row).to eq '32420'
      end
    end

    describe 'invalid zip - with cbsa 99999' do
      let(:zip) { 624 }
      it 'returns nil' do
        expect(subject.fetch_cbsa_row).to be_nil
      end
    end
  end
end
