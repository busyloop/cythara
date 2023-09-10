require "yaml"
require "../../src/cythara/ansi"

describe Cythara do
  describe "#strip_ansi" do
    describe "when string contains VT100 escape codes" do
      YAML.parse(File.read("spec/fixtures/ansi_codes.yaml")).as_a.each do |code|
        it "removes #{code} from #{("ansi" + code.to_s + "code")}" do
          "ansi#{code}code".strip_ansi.should eq("ansicode")
          "ansi#{code}1234".strip_ansi.should eq("ansi1234")
        end
      end
    end

    describe "when string contains display attributes" do
      it "removes basic color codes" do
        "\e[1;33;44;91mfoo\e[0m".strip_ansi.should eq("foo")
      end

      it "removes 256 color codes" do
        "\e[38;5;255mfoo\e[0m".strip_ansi.should eq("foo")
      end

      it "removes 24-bit color codes" do
        "\e[48;2;255;255;255mfoo\e[0m".strip_ansi.should eq("foo")
      end

      it "removes erasing codes" do
        "\e[123Kfoo\e[0m".strip_ansi.should eq("foo")
      end
    end

    describe "when string contains hyperlink escape sequence" do
      it "removes escape codes and returns empty string when label is empty" do
        "\e]8;;https://google.com\e\\\e]8;;\e\\".strip_ansi.should eq("")
      end

      it "removes escape codes and returns label when is present" do
        "\e]8;;https://google.com\e\\label\e]8;;\e\\".strip_ansi.should eq("label")
      end

      it "removes escape codes correctly when params part is present" do
        "\e]8;key1=value1:key2=value2;https://google.com\alabel1\e]8;;\e\\".strip_ansi.should eq("label1")
        "\e]8;invalid-params;https://google.com\alabel2\e]8;;\e\\".strip_ansi.should eq("label2")
      end

      it "removes escape codes, leaving other characters that are not part of sequence" do
        "before_\e]8;;https://google.com\alabel\e]8;;\a_after".strip_ansi.should eq("before_label_after")
      end

      it "correctly removes escape codes when non-standard \\a terminator is used" do
        "before_\e]8;;https://google.com\alabel\e]8;;\e\\_after".strip_ansi.should eq("before_label_after")
      end
    end
  end

  describe "#contains_ansi?" do
    it "returns false for empty String" do
      Cythara.contains_ansi?("").should eq(false)
    end

    it "returns false for String that doesn't contain ANSI codes" do
      Cythara.contains_ansi?("foo").should eq(false)
    end

    it "returns true for String that contains ANSI codes" do
      Cythara.contains_ansi?("\e[33;44mfoo\e[0m").should eq(true)
    end
  end
end
