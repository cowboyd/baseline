module Baseline
  class Parser
    
    def initialize
      @options = {}
    end
  
    def option(&block)
      spec = OptionSpec.new &block
      @options[spec.name] = spec
    end
  
    def parse(str)
      Options.new do |options|        
        str.to_s.split(/\s+/).tap do |args|
          while arg = args.shift do
            case arg
            when /^-(\w)$/
              if spec = @options[$1.to_sym]
                value = spec.switch ? true : args.shift
                options.named spec.name, value
              else
                options.errors << OptionError.new($1, UnknownOptionError)
              end
            else
              options.args << arg
            end
          end
        end
      end
    end
  end
  
  class OptionSpec
    attr_reader :name
    attr_accessor :switch
    
    def initialize
      yield self if block_given?
    end
    
    def name=(name)
      @name = name.to_sym
    end
  end
  
  class Options
    attr_reader :args, :errors
    
    def initialize
      @named, @args, @errors = {},[],[]
      yield self if block_given?
    end
    
    def named name, val
      @named[name.to_s.to_sym] = val
    end
    
    def [](name)
      @named[name]
    end
  end
  
  class OptionError    
    attr_reader :option_name, :error_type
    
    def initialize(name, error_type)
      @option_name, @error_type = name, error_type
    end
  end
  
  class UnknownOptionError < ArgumentError
  end
end