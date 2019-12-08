require 'csv'
require 'open-uri'

class FindMsaByCbsa
  attr_reader :cbsa

  def initialize(cbsa)
    @cbsa = cbsa
  end

  def self.call(cbsa:)
    new(cbsa).get_msa
  end

  def get_msa
    OpenStruct.new(
      msa: msa_row ? msa_row['NAME'] : nil,
      pop2015: msa_row ? msa_row['POPESTIMATE2015'] : nil,
      pop2014: msa_row ? msa_row['POPESTIMATE2014'] : nil
    )
  end

  def msa_row
    @msa_row ||= fetch_msa_row
  end

  def fetch_msa_row
    return unless cbsa
    msa_rows.each do |row|
      if row['LSAD'] == 'Metropolitan Statistical Area' &&
        (row['MDIV'].to_i == cbsa.to_i || row[0].to_i == cbsa.to_i)
        return row
      end
    end
  end

  def msa_rows
    CSV.new(open(csv_url), headers: true)
  end

  def csv_url
    ENV['CBSA_TO_MSA']
  end
end
