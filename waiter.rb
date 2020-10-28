module Bot
  class Waiter
    def initialize(main)
      # TYPE
      # voice_member_join voice_member_leave
      @main = main
      @waiting_jobs = {}
    end

    def add(type,&func)
      @waiting_jobs[type]=[] if @waiting_jobs[type]==nil

      @waiting_jobs[type].push(&func)
    end

    def call(type,event)
      @main.logger.info("Waiter called (#{type.inspect})")
      if @waiting_jobs[type]!=nil
        @waiting_jobs[type].each do |block|
          @main.logger.info("Waiter jobs has called.")
          res = block.call(event)
          if res
            @waiting_jobs[type].delete(block)
          end
        end
      end
    end
  end
end
