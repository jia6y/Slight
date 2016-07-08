require 'slight/config'
require 'slight/template'

module Slight
  class Engine
    def initialize(options = {})

      Configure.set(options) do 
        attr_shortcut "k", "class"
        attr_shortcut "css", "style"
        attr_shortcut "i", "", NoQuote
        attr_shortcut "ln", "href"
        attr_shortcut "url", "href"
        attr_shortcut "char", "charset"
        attr_shortcut "fn", "src"
        attr_shortcut "lang", "language"
        attr_shortcut "value!", "value", NoQuote
        attr_shortcut "xn", "xmlns"
        attr_shortcut "mf", "manifest"

        tag_shortcut "_", "div"
        tag_shortcut "js", %q[script language="javascript"]

        blinding :p, :select
      end

      @template = Template.new(options)
    end

    def render(src_data, local_vars)
      @template.render(src_data, local_vars)
    end

  end
end