$:.unshift File.expand_path('../../lib', __FILE__)
require 'slight'

module Slight
    default_engine = Slight::Engine.new
    io_out = STDOUT
    buffer = ""

    at_exit{
      io_out.close
    }

    begin
      if ARGV[0] == "-h" then
        puts "[Slight] Commands: build | <source_fn> (<dest_fn>) | -v | -h"
      elsif ARGV[0] == "-v" then
        puts VERSION
      elsif ARGV[0] == "build" then
        path = Dir.pwd#File.expand_path(".", __FILE__)
        Dir.entries(path).select { |e| 
          e.include? ".slight"
        }.each{ |src_file|
          buffer << default_engine.render(path + "/" + src_file)
          if buffer != nil and buffer != "" then
            fn = src_file.split(".")[0] << ".htm"
            #puts "#{path}/#{fn}"
            puts "[Slight] Source File [#{src_file}] => Dest File [#{fn}]"
            io_out = File.open("#{path}/#{fn}", 'w')# if ARGV.size == 2
            io_out.puts buffer 
            buffer.clear
          end
        }
      else
        raise IOError, "[Slight] source file was not given." if ARGV.length == 0
        src_file = ARGV[0]
        buffer << default_engine.render(src_file)
        if buffer != nil and buffer != "" then
          fn = ARGV[1] || src_file.split(".")[0] << ".htm"
          io_out = File.open("#{fn}", 'w') #if ARGV.size == 2
          io_out.puts buffer 
        end
      end
    rescue Exception => err
      STDERR.puts "[Slight] " + err.message
      STDERR.puts [err.inspect, err.backtrace.join("\n")].join("\n")
      exit 1
    end

    exit 0
end
