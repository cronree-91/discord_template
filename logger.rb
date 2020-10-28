require 'date'
require 'discordrb'

require_relative "main.rb"
require_relative "run.rb"
require_relative "event.rb"
module Bot
  class Logger
    def initialize(name)
      @name = name
    end
    def info(*args)
      args.each do |a|
        puts "[#{@name}][INFO][#{Time.now.to_i}] #{a}"
      end
    end
    def error(*args)
      args.each do |a|
        puts "\e[31m[#{@name}][ERROR][#{Time.now.to_i}] #{a}\e[0m"
      end
    end
  end
end
