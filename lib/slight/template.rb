require 'slight/dsl'

module Slight
  class Template
    def initialize(options = {})
      @options = options
      @output_buffer = @options[:io_out] || ""
      @dsl = DSL.new(@output_buffer)

      @dsl.resolve_shortcutA(@options[:shortcutA])
      @dsl.resolve_shortcutT(@options[:shortcutT])
      @dsl.resolve_blinding(@options[:blinding])
    end

    def render(src_data, src_file, local_vars = {})
      @output_buffer.clear
      local_vars.each_pair do |key, value|
        @dsl.binding_scope.local_variable_set(key.to_sym, value)
      end
      begin
        eval(src_data, @dsl.binding_scope, src_file, __LINE__ - 20)
      rescue => ex
        raise DSLException.new(ex.message)
      end
      @output_buffer
    end
  end
end
