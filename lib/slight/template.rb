require 'slight/dsl'

module Slight
  class Template 
    def initialize(options = {})
      @output_buffer = ""
      @options = options
      @dsl = DSL.new(@output_buffer)

      resolve_shortcutA(@options[:shortcutA])
      resolve_shortcutT(@options[:shortcutT])
      resolve_blinding(@options[:blinding])
    end

    def render(src_data, local_vars = {})
      @output_buffer.clear
      local_vars.each_pair do |key, value|
        @dsl.binding_scope.local_variable_set(key.to_sym, value)
      end
      begin
        eval(src_data, @dsl.binding_scope, nil, __LINE__ + 1)
      rescue => ex
        raise DSLException.new(ex.message) 
      end
      @output_buffer
    end

    private 
    def resolve_shortcutA(shortcutA)
      dsl_singleton_eval do 
        def __dsl__attr_replacements
          shortcutA
        end
        private :__dsl__attr_replacements
      end
    end

    def resolve_shortcutT(shortcutT)
      dsl_singleton_eval do 
        def __dsl__tag_replacements
          shortcutT
        end
        private :__dsl__attr_replacements
      end
    end

    def resolve_blinding(blinding)
      dsl_singleton_eval do 
        blinding.each do |m|
          undef_method m
        end 
      end
    end

    def dsl_singleton_eval(&blk)
      __dsl__ ||= @dsl.singleton_class
      __dsl__.class_eval(&blk)
    end
  end
end





















