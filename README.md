# Cythara

[![CI](https://github.com/busyloop/cythara/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/busyloop/cythara/actions/workflows/ci.yml?query=branch%3Amaster) [![GitHub](https://img.shields.io/github/license/busyloop/cythara)](https://en.wikipedia.org/wiki/MIT_License) [![GitHub release](https://img.shields.io/github/release/busyloop/cythara.svg)](https://github.com/busyloop/cythara/releases)

A small collection of String helpers.  



## Features

##### Text formatting

* `linewrap` - Wrap a String at a given width
* `wordwrap` - Wrap a String to a given width at word boundaries

##### ANSI

* `contains_ansi?` - Detect ANSI escape codes
* `strip_ansi` - Strip ANSI escape codes



## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     cythara:
       github: busyloop/cythara
   ```

2. Run `shards install`



## API

* 📚 [API Documentation](https://busyloop.github.io/cythara/Cythara.html)

<img src="./assets/pointer.png" width="200" align="left" /><br clear="left" />

## Usage

```crystal
require "cythara/wrap"
Cythara.wordwrap("The quick brown fox", 12) # => ["The quick", "brown fox"]
Cythara.linewrap("The quick brown fox", 12) # => ["The quick br", "own fox"]

require "cythara/ansi"
Cythara.contains_ansi?("\e[31;1mRed Fox") # => true
Cythara.strip_ansi("\e[31;1mRed Fox")     # => "Red Fox"
```



## Usage for lazy monkeys 🐒

```crystal
require "cythara/string"

"The quick brown fox".wordwrap(12) # => ["The quick", "brown fox"]
"The quick brown fox".linewrap(12) # => ["The quick br", "own fox"]

"\e[31;1mRed Fox".contains_ansi? # => true
"\e[31;1mRed Fox".strip_ansi     # => "Red Fox"
```


## Credits

The `strip_ansi` and `contains_ansi?` methods were ported
from the [strings-ansi](https://github.com/piotrmurach/strings-ansi) Ruby gem by Piotr Murach.



## Contributing

1. Fork it (<https://github.com/busyloop/cythara/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

