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

Array.class_eval do

  # Boolean AND of elements
  def band
    inject{ |s,x| s && x }
  end

  # For compatibility purpose.
  def bmap(&blk)
    map(&blk).band
  end

  # Boolean OR of elements
  def bor
    inject{ |s,x| s || x }
  end

  # Call ASE::deepcompact(self)
  def deepcompact
    ASE::deepcompact(self)
  end

  def first=(x)
    raise IndexError, 'empty array' if empty?
    self[0] = x
  end

  def fpop(n=nil)
    n.nil? ? [last,init] : [self[(-n)..(-1)],self[0..(-(n+1))]]
  end

  def fpush(*a)
    self+a
  end

  def fshift(n=nil)
    n.nil? ? [head,tail] : [self[0..(n-1)],self[n..-1]]
  end

  def funshift(*a)
    a+self
  end

  alias :head :first
  alias :head= :first=

  def init
    self[0..-2]
  end

  def last=(x)
    raise IndexError, 'empty array' if empty?
    self[-1] = x
  end

  # Map a function (ie. Method object) to members
  def map_f(f, *args)
    self.map{ |x| f.call(self, *args) }
  end

  # Map a method of members to themselves
  def map_m(sym, *args)
    self.map{ |x| x.send(sym.to_sym, *args) }
  end

  # In-place version of map_m
  def map_m!(sym, *args)
    self.map!{ |x| x.send(sym.to_sym, *args) }
  end

  # Reverse map_m: members are arguments
  def map_mr(sym, obj, *args)
    self.map{ |x| obj.send(sym.to_sym, x, *args) }
  end

  # In-place version of map_mr
  def map_mr!(sym, obj, *args)
    self.map!{ |x| obj.send(sym.to_sym, x, *args) }
  end

  # Return a random element.
  def pick(secure=false)
    @secure_random ||= (RUBY_VERSION < "1.9") ? ActiveSupport::SecureRandom : SecureRandom
    self[secure ? @secure_random.random_number(size) : Kernel.rand(size)]
  end

  def tail
    self[1..-1] || []
  end

  # See vsum for an example of what this does
  # Another example: vapply(:to_a) transposes a matrix!
  def vapply(x)
    (head||[]).zip(*tail).map_m(x)
  end

  # Vector sum
  # For instance: [[1,2],[1,3]].vsum => [2,5]
  def vsum
    vapply(:sum)
  end

end
