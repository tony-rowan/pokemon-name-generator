# Pokémon Name Generator

A command line ruby utility to generate fake (and sometimes accidentally real)
Pokémon names.

## Usage

You can choose between algorithms and configure some aspects of each algorithm.

```bash
$ ruby generate_pokemon_name.rb --algorithm naive
$ ruby generate_pokemon_name.rb --algorithm markov --context 2
```

You can also produce a number of names at once. Useful for exporting to other
apps.

```bash
$ ruby generate_pokemon_name.rb \
  --algorithm markov --context 3 --number 1000 > generated_names.txt
```

## Testing

There's a script to compare the ability of the algorithms to produce sensible
names. It counts how many times an actual Pokémon name is produced and how
often a overly long or short name is produced.

```bash
$ ruby compare_generators.rb
```
