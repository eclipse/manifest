# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with this
# work for additional information regarding copyright ownership.  The ASF
# licenses this file to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations under
# the License.


Gem::Specification.new do |spec|
  spec.name           = 'manifest'
  spec.version        = '0.0.8'
  spec.author         = 'Antoine Toulme'
  spec.email          = "atoulme@intalio.com"
  spec.homepage       = "http://manifest.rubyforge.org"
  spec.summary        = "A MANIFEST.MF file reader"
  spec.description    = <<-TEXT
In the realm of the text file, few files have been as hard to read as MANIFEST.MF.
Frankly, they suck, and we'd better be off without them. That's where we come in.
TEXT
  spec.files          = Dir['{lib}/**/*', '*.{gemspec}'] +
                        ['License.txt', 'README.txt']
  spec.require_paths  = ['lib']
  spec.has_rdoc         = false
end