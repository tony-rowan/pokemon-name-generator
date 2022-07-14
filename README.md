# Pokémon Name Generator

A command line ruby utility to generate fake (and sometimes accidentally real)
Pokémon names.

## Usage

Usage can be very simple.

```bash
$ bin/pokeng generate
```

You can choose between algorithms.

```bash
$ bin/pokeng generate --algorithm=naive
$ bin/pokeng generate --algorithm=markov
```

Some algorithms have additional configuration options.

```bash
$ bin/pokeng generate --algorithm=markov --context=2
```

You can also produce a number of names at once.
Useful for exporting to other apps.

```bash
$ bin/pokeng generate --algorithm=markov --context=3 --number=100000 > generated_names.txt
```

The default options are chosen to produce the most realistic names.

## Testing the Algorithm

You can put an algorithm through a testbed to find out how well it performs.
It counts how many times an actual Pokémon name is produced (from the test and
training data seperately) and how often a overly long or short name is produced.

```bash
$ bin/pokeng test --algorithm=markov --context=2 --number=500000
```
