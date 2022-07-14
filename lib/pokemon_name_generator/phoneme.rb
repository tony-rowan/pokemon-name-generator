module Phoneme
  DATA = File.expand_path("../../../data/phonemes.txt", __FILE__)

  def self.load_data
    File.readlines(DATA, chomp: true)
  end
end
