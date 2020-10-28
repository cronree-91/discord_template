module Bot
  class Util
    def self.get_announce_channel(server,main)
      bot = server.member(main.bot.profile)
      ch = ""
      if server==nil
        return nil
      end
      server.text_channels.sort_by{|x|[x.position,x.id]}.each do |x|
        if bot.can_read_messages?(x) && bot.can_send_messages?(x)
          if x.name.include?("お知らせ")||x.name.include?("おしらせ")||x.name.include?("announce")
            return x
          else
            ch = x if ch==""
          end
        end
      end
      return ch
    end

    def self.update_status(main)
      members_size = 0
      servers_size = 0
      main.bot.servers.each do |id,x|
        begin
          members_size+=x.members.size
          servers_size+=1
        rescue => e
          members_size+=0
          servers_size+=0
        end
      end
      status = "#{servers_size}servers|#{members_size}friends"
      main.logger.info("New Status: #{status}")
      main.bot.update_status("online",status,nil,100000,false,0)
    end
  end
end

