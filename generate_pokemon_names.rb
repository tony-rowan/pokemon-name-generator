phonemes = File.readlines("./phonemes.txt", chomp: true)
pokemon = File.readlines("./pokemon.txt", chomp: true)

puts "🧮 Generating Phonemes"
puts "======================="
pokemon_phonemes = pokemon.map do |this_pokemon_name|
  remaining_pokemon_name = this_pokemon_name
  this_pokemon_phonemes = []

  loop do
    break if remaining_pokemon_name.empty?

    phoneme = phonemes.find { |phoneme| remaining_pokemon_name.start_with?(phoneme) }

    this_pokemon_phonemes << phoneme
    remaining_pokemon_name = remaining_pokemon_name.sub(phoneme, "")
  end

  [this_pokemon_name, this_pokemon_phonemes]
end.to_h

puts "✅ Generated Phonemes"
puts "======================"
pp pokemon_phonemes

puts "🧮 Generating Phoneme Statistics"
puts "================================="
stats = {
  phoneme_count_distribution: pokemon_phonemes.values.map(&:count),
  phoneme_distribution: pokemon_phonemes.values.flatten
}

puts "✅ Generated Phoneme Statistics"
puts "================================"
puts "Pokemon Name Length"
pp stats[:phoneme_count_distribution]
puts "Pokemon Name Makeup"
pp stats[:phoneme_distribution].tally

puts ""
puts "⭐️ Random Pokemon Name"
puts "======================="
name = stats[:phoneme_count_distribution].sample.times.map { stats[:phoneme_distribution].sample }.join
pp name

puts ""
