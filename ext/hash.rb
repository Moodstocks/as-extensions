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

Hash.class_eval do
  
  class << self
    
    # See Hash#normalize. This does the opposite.
    def renormalize(array)
      r = {}
      array.each do |l|
        s = r
        l[0..-3].each do |x|
          s = (s[x] ||= {})
        end
        if s[l[-2]].nil?
          s[l[-2]] = l.last
        elsif s[l[-2]].nil?.is_a?(Array)
          s[l[-2]].push(l.last)
        else
          s[l[-2]] = [s[l[-2]], l.last]
        end
      end
      r
    end
    
  end # class << self
  
  # Cast keys to symbols.
  def to_sym
    inject({}) do |h, (k,v)|
      h[k.to_sym] = v
      h
    end
  end
  
  # Call ASE::deepcompact(self)
  def deepcompact
    ActiveSupport::Extension::deepcompact(self)
  end
  
  # Transforms a hash-based tree into an array of arrays
  # Example input: {'a'=>'aa', 'b' => {'ba' => 'baa', 'bb' => 'bba'}}
  # Example output: [["a", "aa"], ["b", "bb", "bba"], ["b", "ba", "baa"]]
  def denormalize(trace=[])
    r = Set.new
    self.each_pair do |k,v|
      if v.is_a?(Hash)
        l = v.denormalize(trace + [k])
        l.each do |x|
          r.merge(l) unless (l.respond_to?(:empty?) && l.empty?)
        end
      elsif v.is_a?(Array) || v.is_a?(::Set)
        v.each do |x|
          r.add(trace + [k, x])
        end
      else
        r.add(trace + [k, v]) unless (v.respond_to?(:empty?) && v.empty?)
      end
    end
    r.to_a
  end
  
end
