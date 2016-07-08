require 'slight/config'

module Slight
	class Engine
		def initialize
			@options = {}

			Configure.new(@options) do 
				add_attribute_rule("k", "class")
				add_attribute_rule("css", "style")
				add_attribute_rule("i", "", NoQuote)
				add_attribute_rule("ln", "href")
				add_attribute_rule("url", "href")
				add_attribute_rule("char", "charset")
				add_attribute_rule("fn", "src")
				add_attribute_rule("lang", "language")
				add_attribute_rule("value!", "value", NoQuote)
				add_attribute_rule("xn", "xmlns")
				add_attribute_rule("mf", "manifest")

				add_tag_rule("br", "<br/>")
				add_tag_rule("hr", "<hr/>")
				add_tag_rule("js", %q[<script language="javascript"></script>])

				blinding :p, :select

			end
	end
end