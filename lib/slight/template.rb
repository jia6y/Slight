require 'slight/dsl'

module Slight
  class Template 
    def initialize(options = {})
      @output_buffer = ""
      @options = options
      @dsl = DSL.new(@output_buffer)
      resolve_shortcut(@options)
    end

    def render(src_data, local_vars = {})
      @output_buffer.clear
      local_vars.each_pair do |key, value|
        @dsl.binding_scope.local_variable_set(key.to_sym, value)
      end
      begin
        eval(src_data, @dsl.binding_scope)
      rescue Exception ex
        raise DSLException.new([ex.inspect, ex.backtrace.join("\n")].join("\n")) 
      end
      @output_buffer
    end

    private 
    def resolve_shortcut(options)
      @dsl.class.class_eval do 
        __dsl__resolve_tag_shortcut(@options[:tag_shortcut])
        __dsl__resolve_attr_shortcut(@options[:attr_shortcut])
      end
    end

  end
end





















