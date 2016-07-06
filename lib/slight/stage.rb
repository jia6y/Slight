require 'slight/dsl'

module Slight
  class Base
    include DSL

    def initialize(io = StringIO.new)
      #@file_path = file_path
      @io = io
      @output_buffer = io
    end

    def method_missing(fun, *param, &block)
      __dsl__define(fun)
      DSL.send(fun, *param, &block)
    end

    private :__dsl__define, :__dsl__packup, :__dsl__transform

  end

  class Compiler < Base
    def render(src_data, local_vars, b = binding)
      local_vars.each_pair do |key, value|
        b.local_variable_set(key.to_sym, value)
      end
      cur = @output_buffer.pos
      eval(src_data, b)
      @output_buffer.pos = cur == 0 ? 0 : cur + 1
    end

  end

end





















