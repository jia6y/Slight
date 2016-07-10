# Borrow from Puma Source
# Puma::Delegation.forward @ delegation.rb
module Slight
  module Delegation
    def delegate(what, who)
      module_eval <<-CODE
        def #{what}(*args, &block)
          #{who}.#{what}(*args, &block)
        end
      CODE
    end
  end
end