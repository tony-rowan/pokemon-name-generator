# Pokémon Name Generator

![Lint](https://github.com/tony-rowan/pokemon-name-generator/actions/workflows/lint.yml/badge.svg)
![Test](https://github.com/tony-rowan/pokemon-name-generator/actions/workflows/test.yml/badge.svg)
[![Gem Version](https://badge.fury.io/rb/pokemon_name_generator.svg)](https://badge.fury.io/rb/pokemon_name_generator)

A command line ruby utility to generate fake (and sometimes accidentally real)
Pokémon names.

## Installation

Install the utility with

```bash
$ gem install pokemon_name_generator
```

## Usage

Once installed, you will have the command `pokeng` available.

Usage can be very simple.

```bash
$ pokeng generate
```

You can choose between algorithms.

```bash
$ pokeng generate --algorithm=naive
$ pokeng generate --algorithm=markov
```

Some algorithms have additional configuration options.

```bash
$ pokeng generate --algorithm=markov --context=2
```

You can also produce a number of names at once.
Useful for exporting to other apps.

```bash
$ pokeng generate --algorithm=markov --context=3 --number=100000 --quiet > generated_names.txt
```

The default options are chosen to produce the most realistic names.

## Testing an Algorithm

You can put an algorithm through a testbed to find out how well it performs.
It counts how many times an actual Pokémon name is produced (from the test and
training data seperately) and how often a overly long or short name is produced.

```bash
$ pokeng test --algorithm=markov --context=2 --number=500000
```
