require "./version"

module Cythara
  # :nodoc:
  # https://www.alphatrad.com/news/longest-words-in-the-world
  BUF_SIZE = 195

  # Returns a word-wrapped representation of `string`.
  #
  # **Example:**
  # ```
  # Cythara.wordwrap("The quick brown fox", 11) => ["The quick", "brown fox"]
  # ```
  def self.wordwrap(string : String, width : Int32, separators = [' ', '\n'], breakers = ['-']) : Array(String)
    raise ArgumentError.new("width must be > 0") if width < 1

    lines = [] of String
    line = String::Builder.new(width)

    tokens = Deque(String).new
    token = String::Builder.new(BUF_SIZE)

    string.each_char do |char|
      if separators.includes?(char)
        tokens << token.to_s unless token.empty?
        token = String::Builder.new(BUF_SIZE)
        next
      end

      token << char

      if breakers.includes?(char)
        tokens << token.to_s unless token.empty?
        token = String::Builder.new(BUF_SIZE)
      end
    end

    tokens << token.to_s unless token.empty?

    x = 0
    last_char = nil
    while token = tokens.shift?
      if x + token.size > width
        if x == 0
          lines << token[0..width - 1]
          tokens.unshift(token[width..-1])
          line = String::Builder.new(width)
          x = 0
        else
          x + token.size > width - 1
          tokens.unshift(token)
          lines << line.to_s
          line = String::Builder.new(width)
          x = 0
        end
      else
        line << " " unless x == 0 || breakers.includes? last_char
        line << token
        last_char = token[-1]
        x += token.size + 1
      end
    end
    lines << line.to_s unless line.empty?
    lines
  end

  # Returns a line-wrapped representation of `string`.
  #
  # **Examples:**
  # ```
  # Cythara.linewrap("The quick brown fox", 6)        => ["The qu", "ick br", "own fo", "x"]
  # Cythara.linewrap("The quick brown fox", 15)       => ["The quick brown", "fox"]
  # Cythara.linewrap("The quick brown fox", 15, false) => ["The quick brown", " fox"]
  # ```
  def self.linewrap(string : String, width : Int32, strip_leading_space = true) : Array(String)
    raise ArgumentError.new("width must be > 0") if width < 1

    lines = [] of String

    s = String::Builder.new(width)
    x = 0
    string.each_char do |char|
      char = ' ' if char == '\n'
      next if strip_leading_space && x == 0 && char == ' '
      s << char
      x += 1
      if x == width
        lines << s.to_s
        s = String::Builder.new(width)
        x = 0
      end
    end
    lines << s.to_s if x > 0
    lines[-1] = lines[-1].rstrip
    lines
  end
end
