$:.unshift File.dirname(__FILE__)

class Manifest
  attr_accessor :entries

  def initialize
      @entries = Hash.new
  end

  def parse(text)
     
  end
end

