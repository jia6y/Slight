require 'slight/dsl'

module Slight
  class Base
    include DSL

    def initialize(options, io = StringIO.new)
      @io = io
      @output_buffer = io
      @options = options
    end

    def method_missing(fun, *param, &block)
      __dsl__define(fun)
      DSL.send(fun, *param, &block)
    end

    private :__dsl__define, :__dsl__packup

  end

  class Template < Base
    def render(src_data, local_vars, b = binding)
      local_vars.each_pair do |key, value|
        b.local_variable_set(key.to_sym, value)
      end
      cur = @output_buffer.pos

      begin
        eval(src_data, b)
      rescue Exception e
        return "#{e.message}<br>" + 
               "┗>#{e.inspect.to_html}<br>..." +
               "┗>#{e.backtrace.join('<br>.........')}"
      end

      @output_buffer.pos = cur == 0 ? 0 : cur + 1
      @output_buffer
    end

  end

end





















