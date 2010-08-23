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

module ActiveSupport module Extension
  
  ASE = self
  
  class << self
    
    # Require a part / parts of a library
    def require_part(part, dir=nil)
      orig = caller(1).first.split(':').first
      dir ||= File.join( File.dirname(orig), File.basename(orig, ".rb") )
      if part.is_a? Array
        part.each do |p| require_part(p, dir) end
      else
        require File.join(dir, part)
      end
    end
    
    # Require an extension / extensions of a library
    def require_ext(ext, dir=nil)
      orig = caller(1).first.split(':').first
      dir ||= File.join( File.dirname(File.dirname(orig)), 'ext' )
      if ext.is_a? Array
        ext.each do |e| require_ext(e, dir) end
      else
        require File.join(dir, ext)
      end
    end

  end # class << self

  # This loading order (need, logger, log) is necessary to bootstrap need()
  ASE::require_part 'need'
  ASE::need 'logger'
  ASE::require_part 'log'
  
  # Now we can load everything normally
  ASE::need %w{ active_support fileutils uri }
  ASE::require_part %w{ fs enum deep slugstring test time ext-logic }
  ASE::require_ext %w{ array datetime dir hash io object string symbol time }

end end
