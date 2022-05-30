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

puts "🧮 Generating Markov Statistics"
puts "================================="
markov_statistics = {}
pokemon_phonemes.each do |pokemon, this_pokemon_phonemes|
  current_phoneme = nil

  this_pokemon_phonemes.each do |this_pokemon_phoneme|
    if markov_statistics[current_phoneme]
      markov_statistics[current_phoneme] << this_pokemon_phoneme
    else
      markov_statistics[current_phoneme] = [this_pokemon_phoneme]
    end
    current_phoneme = this_pokemon_phoneme
  end

  if markov_statistics[current_phoneme]
    markov_statistics[current_phoneme] << nil
  else
    markov_statistics[current_phoneme] = [nil]
  end
end

puts "✅ Generated Markov Statistics"
puts "================================"
puts "Pokemon Name Length"
pp markov_statistics

puts ""
puts "⭐️ Random Pokemon Name"
puts "======================="
pokemon_name = ""
current_phoneme = markov_statistics[nil].sample
loop do
  break if current_phoneme.nil?

  pokemon_name << current_phoneme
  current_phoneme = markov_statistics[current_phoneme].sample
end
puts pokemon_name

puts ""
