require 'slight/dsl'

module Slight
	class Stage

		def initialize(file_path, io = StringIO.new)
			@io = io
			@dsl = DSL.new(io)
		end

		def transform(file_path)
			@dsl.transform(file_path)
		end

	end
end