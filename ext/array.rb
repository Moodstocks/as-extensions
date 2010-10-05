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

Array.class_eval do
  
  # Boolean map: same as map but returns a boolean intersection of the resulting values.
  # Hence, the return type of this is a boolean.
  def bmap(&blk)
    map(&blk).inject{ |s,x| s && x }
  end
  
  # Call ASE::deepcompact(self)
  def deepcompact
    ActiveSupport::Extension::deepcompact(self)
  end
  
  alias :head :first
  
  def init
    self[0..-2]
  end
  
  # Map a function (ie. Method object) to members
  def map_f(f, *args)
    self.map{ |x| f.call(self, *args) }
  end
  
  # Map a method of members to themselves
  def map_m(sym, *args)
    self.map{ |x| x.send(sym.to_sym, *args) }
  end
  
  # Reverse map_m: members are arguments
  def map_mr(sym, obj)
    self.map{ |x| obj.send(sym.to_sym, x) }
  end
  
  # Return a random element.
  def pick(secure=false)
    self[secure ? ActiveSupport::SecureRandom.random_number(size) : Kernel.rand(size)]
  end
  
  def tail
    self[1..-1] || []
  end
  
end
