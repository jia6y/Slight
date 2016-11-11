require 'slight/utils'

module Slight
  module DSLEssential
    def br; echo "<br/>\n"; end
    def hr; echo "<hr/>\n"; end
    def title(str); echo "<title>#{str}</title>\n"; end
    def js(str); echo "<script  language=\"javascript\">\n#{str}\n</script>\n"; end

    def doctype(type)
      case type
      when :html, :h5
        echo "<!DOCTYPE html>\n"
      when :h11
        echo %q[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">] + "\n"
      when :strict
        echo %q[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">] + "\n"
      when :frameset
        echo %q[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">] + "\n"
      when :mobile
        echo %q[<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">] + "\n"
      when :basic
        echo %q[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN" "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">] + "\n"
      when :transitional
        echo %q[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">] + "\n"
      when :xml
        echo %q[<?xml version="1.0" encoding="utf-8" ?>\n]
      end
    end

    def use(uri, type=nil)
      case type ||= uri.split('.')[-1]
      when "js"
        echo "<script type=\"text/javascript\" src=\"#{uri}\"></script>\n"
      when "css"
        echo "<link rel=\"stylesheet\" href=\"#{uri}\"></link>\n"
      end
    end

    # load another page into current page
    def layout_yield(target_src)

    end

    # set the placeholder in current page
    def layout_placeholder(ph_alias="default")
      echo "<!--######|PLACEHOLDER-#{ph_alias}|######-->"
    end

    # attach itself to the placeholder in anther page
    def layout_attach(page, ph_alias="default")

    end

  end

  class DSLException < ScriptError ; end

  class DSL
    include DSLEssential
    include Utils
    undef :p, :select

    def initialize(io)
      @output_buffer = io
    end

    def puts(str); @output_buffer << html_escape(str); nil; end

    def echo(str); @output_buffer << str; nil; end

    def method_missing(fun, *param, &block)
      __dsl__define(fun)
      self.send(fun, *param, &block)
    end

    def binding_scope
      binding
    end

    def resolve_shortcutA(shortcutA)
      @__dsl__attr_replacements = shortcutA
    end

    def resolve_shortcutT(shortcutT)
      @__dsl__tag_replacements = shortcutT
    end

    def resolve_blinding(blinding)
      blinding.each do |m|
          undef_method m
      end
    end

    private
    def __dsl__define(tag)
      DSL.class_eval do
        define_method(tag){|*at, &block|
          __dsl__packup(tag.to_s, *at, &block)
        }
      end
    end

    def __dsl__packup(tag, *at)
      attr_replacements = @__dsl__attr_replacements||{}
      tag_replacements = @__dsl__tag_replacements||{}
      attrs=[]

      if self_close = tag.end_with?("!") then
        tag = tag[0..-2]
      end

      at.each do |var|
        if var.class == Hash then
          var.each_pair do |a, v|
            unless a.to_sym == :_ then
              at_new = attr_replacements.fetch(a, a)
              at_new = v.class == String ? "#{at_new}=\"#{v}\"" : "#{at_new}=#{v.to_s}"
            else
              at_new = "#{v}"
            end
            attrs.push at_new
          end
        elsif var.class == String
          attrs.push "class=\"#{var}\""
        end
      end

      s_tag = tag_replacements.fetch(tag.to_sym, tag)
      e_tag = s_tag.split(" ")[0]

      space = attrs.length > 0 ? " " : ""
      echo "<#{s_tag}#{space}#{attrs.join(" ")}"
      if self_close then
        echo "/>\n"
      else
        echo ">\n"
        puts yield.to_s if block_given?
        echo "</#{e_tag}>\n"
      end

    end
  end
end
