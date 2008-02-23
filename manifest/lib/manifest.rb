# Copyright Antoine Toulme 2008

$:.unshift File.dirname(__FILE__)

MANIFEST_LINE_SEP = /\r\n|\n|\r[^\n]/
MANIFEST_SECTION_SEP = /(#{MANIFEST_LINE_SEP}){2}/


module ManifestReader

  def read(text)
    
    text.split(MANIFEST_SECTION_SEP).reject { |s| s.chomp == "" }.map do |section|
      section.split(MANIFEST_LINE_SEP).each { |line| line.length.should < 72 }.inject([]) { |merged, line|
        if line[0] == 32
          merged.last << line[1..-1]
        else
          merged << line
        end
        merged
        }.map { |line| line.split(/: /) }.inject({}) { |map, (name, values)|
                                                                         valuesAsHash = {}
                                                                         values.split(/,/).inject([]) { |array, att1| 
 
                                                                                                              if (/[\]|\[|\)|\(]"$/.match(att1))
                                                                                                                 last = array.pop
                                                                                                                 array << "#{last},#{att1}" 
                                                                                                              else
                                                                                                                 array << att1
                                                                                                              end
                                                                                                          }.each { |attribute|
                                                                                                            optionalAttributes = {}
                                                                                                            values = attribute.split(/;/)
                                                                                                            value = values.shift
                                                                                                            values.each {|attribute| 
                                                                                                                                 array = attribute.split(/:?=/) 
                                                                                                                                 array[0] = /\b(.*)/.match(array.first)[0]
                                                                                                                                 optionalAttributes[array.first.chomp] = array.last.chomp
                                                                                                                                }
                                                                                                            valuesAsHash[value] = optionalAttributes
                                                                                                          }
                                                                         map.merge(name=>valuesAsHash) 
                                                                     }
      end
   end
end

class Manifest
  include ManifestReader
  
  attr_accessor  :sections

  def initialize(text)
    @sections = read(text)
  end
end
