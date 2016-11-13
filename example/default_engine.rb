$:.unshift File.expand_path('../../lib', __FILE__)
require 'slight'

module Slight
    default_engine = Slight::Engine.new
    io_out = STDOUT

    at_exit{
      io_out.close
    }

    begin
      if ARGV[0] == "-v" then
        io_out.puts VERSION
      else
        raise IOError, "source file was not given." if ARGV.length == 0
        src_file = ARGV[0]
        io_out = File.open("#{ARGV[1]}", 'w') if ARGV.size == 2
        io_out.puts default_engine.render(src_file)
      end
    rescue Exception => err
      STDERR.puts err.message
      #STDERR.puts [err.inspect, err.backtrace.join("\n")].join("\n")
      exit 1
    end

    exit 0
end
