require 'slight/config'
require 'slight/engine'

module Slight
  class PrettyRender < Filter
    def self.do(src_data); end
  end

  class PrettyOutput < Filter
  end

  conf = Slight::Configuration.new do |c|
    c.use PrettyRender
    c.use PrettyOutput, :after
    #c.set :pretty_html, true
  end

  custom_engine = Slight::Engine.new(conf)
  io_out = STDOUT

  at_exit{
    io_out.close
  }

  begin
    raise IOError, "source file was not given." if ARGV.length == 0
    src_file = ARGV[0]
    io_out = File.open("#{ARGV[1]}", 'w') if ARGV.size == 2
    io_out.puts default_engine.render(src_file)
  rescue Exception => err
    STDERR.puts err.message
    STDERR.puts [err.inspect, err.backtrace.join("\n")].join("\n")
    exit 1
  end

  exit 0
end
