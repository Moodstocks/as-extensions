#--
# Copyright (c) 2010 Moodstocks SAS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# or in the LICENSE file which you should have received as part of
# this distribution.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#++

URI.class_eval do
  
  ASE_UNSAFE_CHARS = /\~|\[|\]/
  
  class << self
    
    alias :parse_noase :parse
    # Encode accented and unsafe characters in URI strings before parsing
    def parse(uri)
      if uri.is_a?(String)
        uri = encode(uri)
        if uri.match(ASE_UNSAFE_CHARS) && ( (s1 = uri.split('://')).length == 2 )
          s2 = s1[1].split(':')
          if s2[0].match(ASE_UNSAFE_CHARS)
            '~[]'.chars.each { |c| s2[0].gsub!(c, "%#{c.unpack("H2").first.upcase}") }
            s1[1] = s2.join(':')
            uri = s1.join('://')
          end
        end
      end
      parse_noase(uri)
    end
    
  end
  
end
