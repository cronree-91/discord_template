require 'fileutils'
require "yaml"
module Bot
  module Data
    class DB
      def self.get(path,id)
        path = path.split(".")
        if !(File.exist?("db/server-#{id}.yml"))
          puts "yml file db/server-#{id}.yml is not exist.\n ill create it."
          f=File.open("db/server-#{id}.yml", "w+")
          f.write("{}")
          f.close
        end
        f=File.open("db/server-#{id}.yml",'r')
        yaml = YAML.load(f)
        f.close

        path.each do |p|
          if yaml==nil || !yaml.has_key?(p)
            yield if block_given?
            return nil
          else
            yaml = yaml[p]
          end
        end
        return yaml
      end

      def self.save(path,value,id)
        if !(File.exist?("db/server-#{id}.yml"))
          puts "yml file db/server-#{id}.yml is not exist.\n ill create it."
          f=File.open("db/server-#{id}.yml", "w+")
          f.write("{}")
          f.close
        end
        f=File.open("db/server-#{id}.yml",'r')
        yaml = YAML.load(f)
        f.close

        path = path.split(".").map{|a|"[#{a.inspect}]"}.join
        puts "yaml#{path}=#{value.inspect}"
        eval("yaml#{path}=#{value.inspect}")


        f=File.open("db/server-#{id}.yml",'w')
        f.write(YAML.dump(yaml))
        f.close
      end

      def self.add(path,value,id)
        yaml=self.get(path,id)
        if yaml.instance_of?(Array)
          yaml.push(value)
          self.save(path,yaml,id)
        elsif yaml.instance_of?(Integer)||yaml.instance_of?(String)
          self.save(path,[yaml,value],id)
        else
          self.save(path,[value],id)
        end
      end

      def self.remove(path,value,id)
        yaml=self.get(path,id)
        if yaml.instance_of?(Array)
          yaml.delete(value)
          self.save(path,yaml,id)
        elsif yaml.instance_of?(Integer)||yaml.instance_of?(String)
          self.save(path,[],id)
        end
      end
    end

    class Config
      def self.get(path)
        path = path.split(".")
        if !(File.exist?('config.yml'))
          puts "yml file config.yml is not exist.\n ill create it."
          f=File.open('config.yml', "w+")
          f.write("{}")
          f.close
        end
        f=File.open('config.yml','r')
        yaml = YAML.load(f)
        f.close

        path.each do |p|
          if yaml==nil || !yaml.has_key?(p)
            yield if block_given?
            return nil
          else
            yaml = yaml[p]
          end
        end
        return yaml
      end
    end
  end
end
