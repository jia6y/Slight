module Slight  
  module DSLEssential
    def echo(str)
      @output_buffer << str
    end

    def title(str)
      echo "<title>#{str}</title>"
    end

    def doctype(type)
      echo "<!doctype #{type}>"
    end

    def use(uri, type=nil)
      type ||= uri.split('.')[-1]     
      echo %q[<script type="text/javascript" src="#{uri}"></script>] if type == "js"
      echo %q[<link rel="stylesheet" href="#{uri}"></link>] if type == "css"
    end

    def layout_yield(target_src)

    end

    def layout_component(target_src, auto_refresh=0)

    end

  end

  class DSLException < ScriptError ; end

  class DSL
    include DSLEssential
    undef :p, :select

    def initialize(io)
      @output_buffer = io
    end

    def method_missing(fun, *param, &block)
      __dsl__define(fun)
      DSL.send(fun, *param, &block)
    end

    def binding_scope
      binding
    end

    private
    def __dsl__define(dsl)
      DSL.send(:define_method, dsl){|*param|
        __dsl__packup(dsl,*param)
      }
    end

    def __dsl__packup(tag, attribute)
      tag = tag.to_s
      tag.sub!(/^_/,'') if tag.start_with?('_')

      #attribute = @filter.lookup(param)

      echo "<#{tag}"; echo " #{attribute}" if attribute != ''; echo ">"
      sub = yield if block_given?
      echo sub.to_s if sub.class != Hash && sub.class != Array 
      echo "</#{tag}>"
    end

  end
end








