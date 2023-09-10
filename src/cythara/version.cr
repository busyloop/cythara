# A small collection of String helpers
module Cythara
  # :nodoc:
  VERSION = {{ `grep "^version" shard.yml | cut -d ' ' -f 2`.chomp.stringify }}
end
