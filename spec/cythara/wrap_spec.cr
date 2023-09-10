require "../spec_helper"

# http://www.paulgraham.com/hp.html
TEXT1 = "When a piece of code is being hacked by three or four different people, no one of whom really owns it, it will end up being like a common-room. It will tend to feel bleak and abandoned, and accumulate cruft. The right way to collaborate, I think, is to divide projects into sharply defined modules, each with a definite owner, and with interfaces between them that are as carefully designed and, if possible, as articulated as programming languages. 1234567890_ABCDEFGHI_1234567890_ABCDEFGHI_1234567890!"

WIDTHS = [1, 2, 3, 5, 8, 13, 21, 34, 55, 89]

describe Cythara do
  describe "#wordwrap" do
    {% for fixture in `find spec/fixtures/wrap/ -type d -mindepth 1 -maxdepth 1`.chomp.lines %}
      fixture_id = File.basename({{fixture}})
      {% for width in WIDTHS %}
        it "correctly wraps #{fixture_id} for width {{width}}" do
          input = File.read(File.join({{fixture}}, "input.txt"))
          value = input.wordwrap({{width}}).map { |s| s.ljust({{width}}, '·') }.join("\n")
          output = File.join({{fixture}}, "wordwrap_{{width}}.txt")
          if ENV["UPDATE_FIXTURES"]? == "1"
            File.write(output, value)
          else
            expect = File.read(output)
            value.should eq(expect)
          end
        end
      {% end %}
    {% end %}
  end

  describe "#linewrap" do
    {% for fixture in `find spec/fixtures/wrap/ -type d -mindepth 1 -maxdepth 1`.chomp.lines %}
      fixture_id = File.basename({{fixture}})
      {% for width in WIDTHS %}
        it "correctly linewraps #{fixture_id} for width {{width}}" do
          input = File.read(File.join({{fixture}}, "input.txt"))
          value = input.linewrap({{width}}, false).map { |s| s.ljust({{width}}, '·') }.join("\n")
          output = File.join({{fixture}}, "linewrap_{{width}}.txt")
          if ENV["UPDATE_FIXTURES"]? == "1"
            File.write(output, value)
          else
            expect = File.read(output)
            value.should eq(expect)
          end
        end

        it "correctly linewraps and strips spaces on #{fixture_id} for width {{width}}" do
          input = File.read(File.join({{fixture}}, "input.txt"))
          value = input.linewrap({{width}}, true).map { |s| s.ljust({{width}}, '·') }.join("\n")
          output = File.join({{fixture}}, "linewrap_strip_{{width}}.txt")
          if ENV["UPDATE_FIXTURES"]? == "1"
            File.write(output, value)
          else
            expect = File.read(output)
            value.should eq(expect)
          end
        end
      {% end %}
    {% end %}
  end
end
