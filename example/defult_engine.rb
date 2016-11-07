$:.unshift File.expand_path('../../lib', __FILE__)
require 'slight'

module Slight 
    default_engine = Slight::Engine.new

    begin
    raise IOError, "source file was not given." if ARGV.length == 0
    src_file = ARGV[0]
    STDOUT.puts default_engine.render(src_file)
    rescue DSLException => errs
    STDERR.puts "Source File Issue: #{src_file}"
    STDERR.puts errs.message
    STDERR.puts [errs.inspect, errs.backtrace.join("\n")].join("\n")
    exit 1
    rescue Exception => errs2
    STDERR.puts errs2.message
    STDERR.puts [errs2.inspect, errs2.backtrace.join("\n")].join("\n")
    exit 1
    end

    exit 0
end