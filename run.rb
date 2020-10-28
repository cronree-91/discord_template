require 'discordrb'
require "dotenv"

require_relative "main.rb"
require_relative "event.rb"
require_relative "logger.rb"

Dotenv.load
bot = Discordrb::Bot.new token: ENV["TOKEN"]
bot_main = Class.new
bot.message() do |event|
  Bot::Event.message(bot_main,event)
end

bot.server_create() do |event|
  Bot::Event.server_create(bot_main,event)
end

bot.voice_state_update do |event|
  if event.old_channel.nil?&&!event.channel.nil?
    Bot::Event.voice_member_join(bot_main,event)
  elsif !event.old_channel.nil?&&event.channel.nil?
    Bot::Event.voice_member_leave(bot_main,event)
  end
end

bot.ready() do |event|
  if ENV["BOT_NAME"].nil?
    print "Bot name:"
    bot_name = gets.chomp
  else
    bot_name = ENV["BOT_NAME"]
  end
  bot_main = Bot::Main.new(event.bot,bot_name)
  Bot::Event.ready(bot_main,event)
end

if __FILE__ == $0
  bot.run()
end
