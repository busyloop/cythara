module Cythara
  # This code was ported from the
  # `strings-ansi` Ruby gem by Piotr Murach:
  # https://github.com/piotrmurach/strings-ansi

  # :nodoc:
  ANSI_REGEX = %r{(?>\033(\[[\[?>!]?\d*(;\d+)*[ ]?[a-zA-Z~@$^\]_\{\\]|\#?\d|[)(%+\-*/. ](\d|[a-zA-Z@=%]|)|O[p-xA-Z]|[a-zA-Z=><~\}|]|\]8;[^;]*;.*?(\033\\|\07)))}

  # Returns `string` with all ANSI escape codes removed.
  def self.strip_ansi(string) : String
    string.gsub(ANSI_REGEX, "")
  end

  # Returns _true_ if `string` contains ANSI escape codes.
  def self.contains_ansi?(string) : Bool
    !!(string =~ ANSI_REGEX)
  end
end
