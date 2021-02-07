require_relative "mod.rb"

module Bot
  class Waiter
    def initialize(main)
      # TYPE
      # voice_member_join voice_member_leave message
      @main = main
      @waiting_jobs = {}
    end

    def jobs
      return @waiting_jobs
    end

    def add(type, name = nil, conf = {}, &func)
      @main.logger.info("[WAITER] called add(#{type})")
      name = "#{type} event" if name.nil?
      @waiting_jobs[type] = [] if @waiting_jobs[type] == nil

      @waiting_jobs[type].push([func, name, conf])

      @main.logger.info("[WAITER] created `#{name}`")
    end

    def remove(type = nil, name)
      @main.logger.info("[WAITER] called remove(#{name})")
      if type == nil
        @waiting_jobs.each do |jobs|
          jobs.each do |f, n, c|
            if n == name
              @waiting_jobs[type].delete([f, n, c])
              @main.logger.info("[WAITER] job deleted `#{name}`")
            end
          end
        end
      else
        @waiting_jobs[type].each do |f, n, c|
          if n == name
            @waiting_jobs[type].delete([f, n, c])
            @main.logger.info("[WAITER] job deleted `#{name}`")
          end
        end
      end
    end

    def call(type, event)
      @main.logger.info("[WAITER] called call(#{type})")
      ret = false
      if @waiting_jobs[type] != nil
        @waiting_jobs[type].each do |block, name, conf|
          @main.logger.info("[WAITER] job call `#{name}`")
          res = block.call(event, conf)
          @main.logger.info("[WAITER] job called `#{name}`")
          if res
            @waiting_jobs[type].delete([block, name, conf])
            @main.logger.info("[WAITER] job deleted `#{name}`")
            ret = true
          end
        end
      end
      return ret
    end
  end
end
