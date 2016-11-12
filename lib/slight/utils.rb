# Borrow from ERB Source
# ERB::Util
module Slight
  module Utils
      public
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

      class PageNode
        def initialize(fn, pnode  = nil)
          @fn = fn
        end

        def root?
          pnode == nil
        end

        def recursive?
          _node = pnode
          while(!_node.root?)
            return true if _node.fn == fn
            _node = _node.pnode
          end
          false
        end
      end
  end
end
