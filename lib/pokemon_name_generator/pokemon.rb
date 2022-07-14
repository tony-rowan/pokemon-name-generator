module Pokemon
  DATA = File.expand_path("../../../data/pokemon.txt", __FILE__)

  def self.load_data
    File.readlines(DATA, chomp: true)
      .map { |line| line[5..] } # drop the number
      .map(&:downcase)
      .reject { |name| name =~ /[♀♂.'2\-é:\ ]/ } # don't deal with special characters yet
  end
end
