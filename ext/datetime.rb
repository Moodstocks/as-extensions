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

DateTime.class_eval do
  
  alias :to_s_noase :to_s
  # Convert to the standard ASE time string format
  def to_s(format=nil)
    if format.nil? then ASE::Time::to_string(self)
    else to_s_noase(format) end
  end
  
  # Get the number of seconds since Epoch
  def to_epoch
    ASE::Time::epoch(self)
  end
  
  # Convert to a Time object
  def to_time
    ASE::Time::to_time(self)
  end
  
end
