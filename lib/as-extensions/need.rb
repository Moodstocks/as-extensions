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

module ASE
  
  # To store gems already need()ed
  NEEDED = {}
  
  class << self
  
    # Require a gem / gems on the fly.
    # Raises an exception if the load fails.
    def need(ext)
      if ext.is_a?(::Array)
        ext.each do |e| need(e) end
      else
        return true if NEEDED[ext]
        begin
          require ext
        rescue Exception
          ASE::log("Couldn't load \"#{ext}\".", :error)
          raise
        end
        NEEDED[ext] = true
      end
    end
  
  end # class << self
  
end
