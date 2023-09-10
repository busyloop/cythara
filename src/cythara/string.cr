require "./ansi"
require "./wrap"

# If you `require "cythara/string"` then the
# following helper-methods become available
# on all your `String`-instances.
class String
  # See `Cythara.wordwrap`
  def wordwrap(width : Int32, separator = [' ', '\n'], breakers = ['-'])
    Cythara.wordwrap(self, width, separator, breakers)
  end

  # See `Cythara.linewrap`
  def linewrap(width : Int32, strip_leading_space = true)
    Cythara.linewrap(self, width, strip_leading_space)
  end

  # See `Cythara.strip_ansi`
  def strip_ansi
    Cythara.strip_ansi(self)
  end

  # See `Cythara.contains_ansi?`
  def contains_ansi?
    Cythara.contains_ansi?(self)
  end
end
