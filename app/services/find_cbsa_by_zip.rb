require 'csv'
require 'open-uri'

class FindCbsaByZip
  attr_reader :zip

  def initialize(zip)
    # Takes care of leading zeroes and helps with comparison
    @zip = zip.to_i
  end

  def self.call(zip:)
    new(zip).fetch_cbsa_row
  end

  def fetch_cbsa_row
    cbsa_rows.each do |row|
      return row['CBSA'] if row[0].to_i == zip && row['CBSA'] != '99999'
    end
  end

  def cbsa_rows
    CSV.new(open(csv_url), headers: true)
  end

  def csv_url
    ENV['ZIP_TO_CBSA']
  end
end
