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

module ActiveSupport module Extension module String
  class << self
    
    # Load a string from a file or a URL.
    def from(where)
      where.strip!
      uri = URI.parse(where)
      is_gz = (where.split('.').last == 'gz')
      case uri.scheme
        when nil
          unless File.file?( where = File.expand_path(where) )
            return ASE::log("#{where} is not a file.", :error)
          end
          open(where) do |f| return IO::to_string(f, is_gz) end
        else
          ASE::need 'open-uri'
          uri.open do |f| return IO::to_string(f, is_gz) end
      end # case
    end
    
  end # class << self
end end end
