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
  
  # Ruby Time classes are a mess. This module attempts to restore
  # order by making bold choices.
  # It provides a standard string format and always uses UTC and Epoch.
  module Time

    DATE_FORMAT = "%Y-%m-%dT%H:%M:%S"
  
    class << self
    
      def now(type=nil)
        case type
          when :string; 0.seconds.ago.strftime(DATE_FORMAT)
          else 0.seconds.ago
        end
      end
    
      # Convert various time classes to string
      def to_string(t)
        t.respond_to?(:getutc) ? t.getutc.strftime(DATE_FORMAT) : t.strftime(DATE_FORMAT)
      end
    
      # Convert an ASE time string to a DateTime
      def from_string(s)
        ::Time.parse("#{s}Z")
      end
    
      # Force conversion of a DateTime to a Time
      def to_time(t)
        if t.is_a?(::Time) then t
        else from_string(to_string(t)) end
      end
    
      # Converts various times to a number of seconds since Epoch
      def epoch(t)
        if t.nil? then epoch(now)
        elsif ( t.is_a?(::Time) || t.is_a?(::Numeric) ) then t.to_i
        elsif t.is_a?(::DateTime) then epoch(to_time(t))
        elsif t.is_a?(::String) then epoch(from_string(t))
        else nil end
      end
    
    end # class << self
  
  end # module Time
  
end end
