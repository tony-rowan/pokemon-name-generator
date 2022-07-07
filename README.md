# Pokémon Name Generator

A command line ruby utility to generate fake (and sometimes accidentally real)
Pokémon names.

## Usage

Usage can be very simple.

```bash
$ ruby generate_pokemon_name.rb
```

You can choose between algorithms.

```bash
$ ruby generate_pokemon_name.rb --algorithm naive
$ ruby generate_pokemon_name.rb --algorithm markov
```

Some algorithms have additional configuration options.

```bash
$ ruby generate_pokemon_name.rb --algorithm markov --context 2
```

You can also produce a number of names at once.
Useful for exporting to other apps.

```bash
$ ruby generate_pokemon_name.rb \
  --algorithm markov --context 3 --number 1000 > generated_names.txt
```

The default options are chosen to produce the most realistic names.

## Testing

There's a script to compare the ability of the algorithms to produce sensible
names. It counts how many times an actual Pokémon name is produced and how
often a overly long or short name is produced.

```bash
$ ruby compare_generators.rb
```
