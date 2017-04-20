require 'tilt'
require 'tilt/template'
require 'slight'

module Tilt
	class SlightTemplate < Template
		self.default_mime_type = 'text/html'

		def prepare
		  @engine = ::Slight::Engine.new
      #@engine = ::ERB.new(data, options[:safe], options[:trim], @outvar)
    end
	
    def evaluate(scope, locals, &block)
      #scope_vars = scope.instance_variables
      #scope_vars.each do |var|
      #  @engine.instance_variable_set(var, scope.instance_variable_get(var))
      #end
      locals[:__scope] = scope
    	@output ||= @engine.render(file, data, locals)
    end
	end

  register_lazy "SlightTemplate",    'slight/tilt',    'slight', 'rb'

end
