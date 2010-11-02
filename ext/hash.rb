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
  
  # Call ASE::deepcompact(self)
  def deepcompact
    ActiveSupport::Extension::deepcompact(self)
  end
  
  # Same logic as get! but for deleting values.
  # Examples with h = {:a=>{:b=>{:c=>:d}}}:
  #   h.del!(:a, :b, :c) # => {:a=>{:b=>{}}}
  #   h.del!(:a, :b){|x| x[:c] == :z} # => {:a=>{:b=>{:c=>:d}}}
  #   h.del!(:a, :b){|x| x[:c] == :d} # => {:a=>{}}
  def del!(*nodes, &blk)
    if nodes.length == 1
      self.delete(nodes.head) if ( (!block_given?) || blk.call(self[nodes.head]) )
    else
      ( self.get!(*nodes.init) {{}} ).del!(nodes.last, &blk)
    end
    self
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
  
  # Get a node in a recursive hash structure and create intermediate hashes if needed.
  # Example:
  #   a = {}
  #   a.get!(:a, :b, :c) # => nil
  #   a # => {:a=>{:b=>{}}}
  # You can pass a block to set the default value for the leaf:
  #   a = {}
  #   a.get!(:a, :b, :c) { :d } # => :d
  #   a # => {:a=>{:b=>{:c=>:d}}}
  def get!(*nodes, &blk)
    return self if (l = nodes.length) == 0
    nh = nodes.head
    if block_given?
      if l == 1
        self[nh] ||= yield
        self[nh]
      else
        self[nh] ||= {}
        self[nh].get!(*(nodes.tail), &blk)
      end
    else
      if l == 1
        self[nh]
      else
        self[nh] ||= {}
        self[nh].get!(*(nodes.tail))
      end
    end
  end
  
  # Keep all keys except those in array x
  def kexcept(x)
    if x.is_a?(Array) then reject{ |k,v| x.include?(k) }
    else kexcept([x]) end
  end
  
  # Keep only keys in array x
  def konly(x)
    if x.is_a?(Array) then select{ |k,v| x.include?(k) }
    else konly([x]) end
  end
  
  # Same logic as get! but for setting values.
  # Example:
  #   {}.set!(:a, :b, :c) { :d } # => {:a=>{:b=>{:c=>:d}}}
  def set!(*nodes, &blk)
    raise "Hash#set! takes a block and at least an argument." unless (block_given? && (l = nodes.length) > 0)
    if l == 1 then self[nodes.head] = yield
    else ( self.get!(*nodes.init) {{}} ).set!(nodes.last, &blk) end
    self
  end
  
  alias :to_sym :symbolize_keys
  
end
