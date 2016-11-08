# Borrow from ERB Source
# ERB::Util

module Slight
  module Utils
      public
      #
      # A utility method for escaping HTML tag characters in _s_.
      #
      #   require "erb"
      #   include ERB::Util
      #
      #   puts html_escape("is a > 0 & a < 10?")
      #
      # _Generates_
      #
      #   is a &gt; 0 &amp; a &lt; 10?
      #
      # [Slight] => Add: gsub(/[[:blank:]]/,"&nbsp;") to support space.
      def html_escape(s)
        s.to_s.gsub(/&/, "&amp;").gsub(/[[:blank:]]/,"&nbsp;").gsub(/\"/, "&quot;").gsub(/>/, "&gt;").gsub(/</, "&lt;")
      end
      module_function :html_escape

      #
      # A utility method for encoding the String _s_ as a URL.
      #
      #   require "erb"
      #   include ERB::Util
      #
      #   puts url_encode("Programming Ruby:  The Pragmatic Programmer's Guide")
      #
      # _Generates_
      #
      #   Programming%20Ruby%3A%20%20The%20Pragmatic%20Programmer%27s%20Guide
      #
      def url_encode(s)
        s.to_s.gsub(/[^a-zA-Z0-9_\-.]/n){ sprintf("%%%02X", $&.unpack("C")[0]) }
      end
      module_function :url_encode
  end
end

# from stack overflow
class String
  # colorization
  def colorize(color_code);  "\e[#{color_code}m#{self}\e[0m"; end
  def light_blue;     "\e[36m#{self}\e[0m"; end
  def black;          "\e[30m#{self}\e[0m"; end
  def red;            "\e[31m#{self}\e[0m"; end
  def green;          "\e[32m#{self}\e[0m"; end
  def yellow;          "\e[33m#{self}\e[0m"; end
  def blue;           "\e[34m#{self}\e[0m"; end
  def magenta;        "\e[35m#{self}\e[0m"; end
  def cyan;           "\e[36m#{self}\e[0m"; end
  def gray;           "\e[37m#{self}\e[0m"; end

  def bg_black;       "\e[40m#{self}\e[0m"; end
  def bg_red;         "\e[41m#{self}\e[0m"; end
  def bg_green;       "\e[42m#{self}\e[0m"; end
  def bg_brown;       "\e[43m#{self}\e[0m"; end
  def bg_blue;        "\e[44m#{self}\e[0m"; end
  def bg_magenta;     "\e[45m#{self}\e[0m"; end
  def bg_cyan;        "\e[46m#{self}\e[0m"; end
  def bg_gray;        "\e[47m#{self}\e[0m"; end

  def bold;           "\e[1m#{self}\e[22m"; end
  def italic;         "\e[3m#{self}\e[23m"; end
  def underline;      "\e[4m#{self}\e[24m"; end
  def blink;          "\e[5m#{self}\e[25m"; end
  def reverse_color;  "\e[7m#{self}\e[27m"; end
end
