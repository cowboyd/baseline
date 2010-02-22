
require File.dirname(__FILE__) + '/../lib/baseline.rb'

include Baseline

describe Baseline do
  
  it "can parse a simple option" do
    Parser.new.tap do |p|
      p.option do |o|
        o.name = "v"
      end
      p.parse("-v 1.9").tap do |options|
        options[:v].should == "1.9"
      end
    end
  end
    
  it "will treat arguments as boolean if the option is a switch and not consume the following argument" do
    Parser.new.tap do |p|
      p.option do |o|
        o.name = "v"
        o.switch = true
      end
      p.parse("-v 1.9").tap do |options|
        options[:v].should be(true)
        options.args.should == ['1.9']
      end
    end
  end
  
  it "is an error if there is an option that is not specified" do
    Parser.new.tap do |p|
      p.parse("-v").errors.tap do |errors|
        errors.length.should == 1
        errors.first.tap do |e|
          e.option_name.should == "v"
          e.error_type.should be(UnknownOptionError)
        end
      end
    end
  end
  
  it "allows long options to be specified if preceded by a --" do
    Parser.new.tap do |p|
      p.option do |o|
        o.name = 'version'
      end
      p.parse("--version=1.9").tap do |options|
        options[:version].should == 1.9
      end
    end
  end
  
  it "allows long options to also be switches"  
  
  it "is optional to use the '=' sign for long options"
  
  it "is illegal for long options that are switches to use the '=' sign"
  
  it "has symbolic options as well as positional arguments"
  
  it "understands arrays as well as strings"

  it "allows you handle missing options that were not specified ahead of time"
end