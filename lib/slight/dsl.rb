require 'slight/utils'

module Slight
  module DSLEssential
    def br; echo "<br/>"; end

    def hr; echo "<hr/>"; end

    def title(str); echo "<title>#{str}</title>"; end

    def doctype(type)
      case type
      when :html, :h5
        echo "<!DOCTYPE html>"
      when :h11
        echo %q[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">]
      when :strict
        echo %q[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">]
      when :frameset
        echo %q[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">]
      when :mobile
        echo %q[<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">]
      when :basic
        echo %q[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN" "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">]
      when :transitional
        echo %q[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">]
      when :xml
        echo %q[<?xml version="1.0" encoding="utf-8" ?>]
      end
    end

    def use(uri, type=nil)
      case type ||= uri.split('.')[-1]
      when "js"
        echo %q[<script type="text/javascript" src="#{uri}"></script>]
      when "css"
        echo %q[<link rel="stylesheet" href="#{uri}"></link>]
      end
    end

    def layout_yield(target_src)

    end

    def layout_component(target_src, auto_refresh=0)

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

    def puts(str); @output_buffer << html_escape(str); end

    def echo(str); @output_buffer << str; end

    def method_missing(fun, *param, &block)
      __dsl__define(fun)
      DSL.send(fun, *param, &block)
    end

    def binding_scope
      binding
    end

    def resolve_shortcutA(shortcutA)
      @__dsl__attr_replacements = shortcutA
    end

    def resolve_shortcutT(shortcutT)
      @__dsl__attr_replacements = shortcutT
    end

    def resolve_blinding(blinding)
      blinding.each do |m|
          undef_method m
      end
    end

    private
    def __dsl__define(tag)
      define_method(tag){|*at, &block|
        __dsl__packup(tag.to_s, *at, &block)
      }
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
              a = attr_replacements.fetch(a, a)
              a = v.class == String ? "#{a}=\"#{v}\"" : "#{a}=#{v.to_s}"
            else
              a = "#{v}"
            end
            attrs.push a
          end
        elsif var.class == String
          attrs.push "class=#{var}"
        end
      end

      s_tag = tag_replacements.fetch(tag, tag)
      e_tag = s_tag.split(" ")[0]

      space = attrs.length > 0 ? " " : ""
      echo "<#{s_tag}#{space}#{attrs.join(" ")}"
      if self_close then
        echo "/>"
      else
        puts yield.to_s if block_given?
        echo "</#{e_tag}>"
      end
    end

  end
end
