require_relative "util.rb"
require_relative "mod.rb"
require_relative "logger.rb"
require_relative "main.rb"
require_relative "run.rb"

module Bot
  class Event
    def self.ready(main,event)
      main.logger.info("Called Bot::Event.ready")
      main.logger.info("Bot name: #{event.bot.profile.name}")
      main.logger.info("Bot is ready.")

      Util.update_status(main)
    end
    def self.voice_member_join(main,event)
      main.logger.info("Called Bot::Event.voice_member_join",
                       "  SERVER: #{event.server.name}",
                       "    ID: #{event.server.name}",
                       "    OWNER: #{event.server.owner.name}",
                       "      ID: #{event.server.owner.id}",
                       "    REGION: #{event.server.region_id}",
                       "  CHANNEL: #{event.channel.name}",
                       "    ID: #{event.channel.id}",
                       "  USER: #{event.user.name}",
                       "    ID: #{event.user.id}"
                      )
      main.waiter.call(:voice_member_join,event)
    end
    def self.voice_member_leave(main,event)
      main.logger.info("Called Bot::Event.voice_member_leave",
                       "  SERVER: #{event.server.name}",
                       "    ID: #{event.server.name}",
                       "    OWNER: #{event.server.owner.name}",
                       "      ID: #{event.server.owner.id}",
                       "    REGION: #{event.server.region_id}",
                       "  CHANNEL: #{event.old_channel.name}",
                       "    ID: #{event.old_channel.id}",
                       "  USER: #{event.user.name}",
                       "    ID: #{event.user.id}"
                      )
      main.waiter.call(:voice_member_leave,event)
    end
    def self.member_join(main,event)
      main.logger.info("Called Bot::Event.member_join",
                       "  SERVER: #{event.server.name}",
                       "    ID: #{event.server.name}",
                       "    OWNER: #{event.server.owner.name}",
                       "      ID: #{event.server.owner.id}",
                       "    REGION: #{event.server.region_id}")
      Util.update_status(main)
    end
    def self.member_leave(main,event)
      main.logger.info("Called Bot::Event.member_leave",
                       "  SERVER: #{event.server.name}",
                       "    ID: #{event.server.name}",
                       "    OWNER: #{event.server.owner.name}",
                       "      ID: #{event.server.owner.id}",
                       "    REGION: #{event.server.region_id}")
      Util.update_status(main)
    end
    def self.message(main,event)
      main.logger.info("Called Bot::Event.message",
                       "  ID: #{event.message.id}",
                       "  SERVER: #{event.server.name}",
                       "    ID: #{event.server.name}",
                       "    OWNER: #{event.server.owner.name}",
                       "      ID: #{event.server.owner.id}",
                       "    REGION: #{event.server.region_id}",
                       "  CONTENT: #{event.message.content}")
      msg = event.message
      if msg.content=="/help"
        Mod::Help.call(main,msg)
      else
        if /\A[a-zA-Z]+\/.+\z/ === msg.content
          text = msg.content.split("/",2)
          case text[0]
          end
        else
          main.logger.info("This is not bot command.")
        end
      end
    end
    def self.server_create(main,event)
      Util.update_status(main)
      main.logger.info("Called Bot::Event.server_create",
                       "SERVER: #{event.server.name}",
                       "  ID: #{event.server.name}",
                       "  OWNER: #{event.server.owner.name}",
                       "    ID: #{event.server.owner.id}",
                       "  REGION: #{event.server.region_id}"
                      )
    end
  end
end

