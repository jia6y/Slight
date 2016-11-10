require 'slight/config'
require 'slight/template'
#require 'slight/filter/pretty_html'
module Slight
  class Engine
    def initialize(options = {})
      @options = options
      Configuration.new(@options) do |c|
        c.shortcut :A, :css, "style"
        c.shortcut :A, :ln, "href"
        c.shortcut :A, :url, "href"
        c.shortcut :A, :char, "charset"
        c.shortcut :A, :fn, "src"
        c.shortcut :A, :lang, "language"
        c.shortcut :A, :xn, "xmlns"
        c.shortcut :A, :mf, "manifest"
        c.shortcut :T, "_", "div"
        c.shortcut :T, "js", %q[script language="javascript"]
       #c.use PrettyHtmlOutput, :after if c.get(:pretty_html)
      end
      @template = Template.new(@options)
    end

    def render(src_file, src_data = nil, local_vars={})
      # src file is mainly using for identify issues for debugging
      # if data not given then read data from src file
      src_data ||= File.new(src_file).read
      @options[:before_filter].each do |f|
        src_data = f.do(src_data)
      end
      src_data = @template.render(src_data, src_file, local_vars)
      @options[:after_filter].each do |f|
        src_data = f.do(src_data)
      end
      src_data
    end
  end
end
