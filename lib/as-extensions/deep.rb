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

module ASE; class << self
  
  # Remove nil values in a recursive data structure composed
  # of hashes and arrays.
  def deepcompact(x)
    if x.is_a?(::Array)
      x.reject{ |x| x.nil? }.map{ |x| deepcompact(x) }
    elsif x.is_a?(::Hash)
      ret = {}
      x.each_pair do |k,v|
        ret[k] = deepcompact(v) if !v.nil?
      end
      ret
    else
      x
    end
  end
  
end end # class << self
