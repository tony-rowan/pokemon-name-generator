module Pokemon
  DATA = "./data/pokemon.txt"

  def self.load_data
    File.readlines(DATA, chomp: true)
  end
end
