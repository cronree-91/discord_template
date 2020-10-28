require_relative 'data.rb'
module Bot
  class Repo

    def self.lang(guild)
      lang = Data::DB.get('lang',guild.id)
      if lang.nil?
        Data::DB.save("lang","ja",guild.id)
        lang = Data::DB.get('lang',guild.id)
      end
      return Data::DB.get('lang',guild.id)
    end
  end
end
