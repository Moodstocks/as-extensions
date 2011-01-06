#--
# Copyright (c) 2010-2011 Moodstocks SAS
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

Socket.class_eval do
  
  class << self
    # Thanks to 'coderrr'
    def local_ip(force_reload=false)
      @ase_local_ip = nil if force_reload
      @ase_local_ip ||= begin
        # turn off reverse DNS resolution temporarily
        orig, do_not_reverse_lookup = do_not_reverse_lookup, true
        UDPSocket.open do |s|
          s.connect('184.106.196.237', 1)
          s.addr.last
        end
      ensure
        do_not_reverse_lookup = orig
      end
    end
    
  end
  
end
