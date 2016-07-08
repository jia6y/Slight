module Slight
  module Delegation
    def delegate(what, who)
      instance_eval <<-CODE
        def #{what}(*args, &block)
          #{who}.#{what}(*args, &block)
        end
      CODE
    end
  end
end

include Slight::Delegation

