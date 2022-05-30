module Phoneme
  DATA = "./data/phonemes.txt"

  def self.load_data
    File.readlines(DATA, chomp: true)
  end
end
