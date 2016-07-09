require 'slight/config'
require 'slight/template'

module Slight
  class Engine

    def initialize(options = {})
      @options = options
      configure(@options) do |c|
        c.shortcut :A, "k", "class"
        c.shortcut :A, "css", "style"
        c.shortcut :A, "i", "", NoQuote
        c.shortcut :A, "ln", "href"
        c.shortcut :A, "url", "href"
        c.shortcut :A, "char", "charset"
        c.shortcut :A, "fn", "src"
        c.shortcut :A, "lang", "language"
        c.shortcut :A, "xn", "xmlns"
        c.shortcut :A, "mf", "manifest"
        c.shortcut :T, "_", "div"
        c.shortcut :T, "js", %q[script language="javascript"]
      end

      @template = Template.new(@options)
    end

    def render(src_data, local_vars)
      @options[:prep].each do |prep|
        src_data = prep.scan(src_data)
      end
      @template.render(src_data, local_vars)
    end

  end
end