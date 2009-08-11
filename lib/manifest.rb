###############################################################################
# Copyright (c) 2008-2009 Manifest and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#     Antoine Toulme - initial API and implementation
###############################################################################

$:.unshift File.dirname(__FILE__)

module Manifest

  MANIFEST_LINE_SEP = /\r\n|\n|\r[^\n]/
  MANIFEST_SECTION_SEP = /(#{MANIFEST_LINE_SEP}){2}/

  def read(text)

    text.split(MANIFEST_SECTION_SEP).reject { |s| s.chomp == "" }.map do |section|
      section.split(MANIFEST_LINE_SEP).each { |line| line.length < 72 }.inject([]) { |merged, line|
        if line[0] == 32
          merged.last << line[1..-1]
        else
          merged << line
        end
        merged
        }.map { |line| line.split(/: /) }.inject({}) { |map, (name, values)|
          if (values.nil?)
            map.merge!(name=>nil)
          else
            valuesAsHash = {}
            values.split(/,/).inject([]) { |array, att1| 

              if (/[\]|\[|\)|\(]"/.match(att1))
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
                  optionalAttributes.merge!(array.first.strip=>array.last.strip)
                }
                valuesAsHash.merge!(value=>optionalAttributes)
              }
              map.merge!(name=>valuesAsHash) 
            end
          }
        end
      end

      module_function :read
    end
