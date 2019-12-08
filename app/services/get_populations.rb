class GetPopulations
  attr_reader :zip

  def initialize(zip)
    @zip = zip
  end

  def self.call(zip:)
    new(zip).populations
  end

  def populations
    {
      zip: zip,
      cbsa: cbsa,
      msa: msa.msa,
      pop2015: msa.pop2015,
      pop2014: msa.pop2014
    }
  end

  def cbsa
    @cbsa ||= FindCbsaByZip.call(zip: zip)
  end

  def msa
    @msa ||= FindMsaByCbsa.call(cbsa: cbsa)
  end
end