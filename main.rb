require "discordrb"

require_relative 'run.rb'
require_relative 'waiter.rb'
require_relative 'logger.rb'
require_relative 'event.rb'
module Bot
  class Main
    attr_reader :bot, :name
    def initialize(bot,name)
      @bot = bot
      @name = name
      @logger = Logger.new(name)
      @waiter = Waiter.new(self)
    end
    def logger
      return @logger
    end

    def waiter
      return @waiter
    end
  end
end
