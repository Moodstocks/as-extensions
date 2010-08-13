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

# Simple test methods for as-extensions
# Their main advantage over unit/test
# is that they can run tests in isolation.

module ActiveSupport module Extension module Test
    
  CONFIG = { :verbose => (ARGV.include?('verbose')),
             :fatal => (ARGV.include?('fatal')),
             :nb_ok => 0,
             :nb_nok => 0,
             :mute_stats => false }
  
  class << self
    
    def debug(s)
      puts s if CONFIG[:verbose]
    end
    
    def stats(mute=nil)
      CONFIG[:mute_stats] = mute if !mute.nil?
      return if CONFIG[:mute_stats]
      puts "=== TEST STATS ==="
      puts "OK: #{CONFIG[:nb_ok]}"
      puts "NOK: #{CONFIG[:nb_nok]}"
    end
  
    def msg_stack(msg1=nil, msg2=nil)
      if msg1
        if msg2 then "#{msg1}\nERROR ==> #{msg2}"
        else msg1 end
      elsif msg2 then msg2
      else nil end        
    end
  
    def assert(success=nil, msg=nil)
      if success
        CONFIG[:nb_ok] += 1
        debug "Test \##{CONFIG[:nb_ok]+CONFIG[:nb_nok]} OK"
        return true
      else
        CONFIG[:nb_nok] += 1
        debug "=== TEST NOT OK ==="
        debug caller.join("\n")
        puts "ERROR ==> #{msg}" if msg
        raise $! if CONFIG[:fatal]
        return false
      end
    end
    
    def assert_fail(msg=nil)
      assert false, msg
    end
  
    def assert_boolean(b=nil, msg=nil)
      assert (b == true || b == false), msg_stack(msg, "Expected a boolean, found a #{b.class}.")
    end
  
    def assert_true(b=nil, msg=nil)
      assert_boolean b, msg
      assert b, msg
    end
    
    def assert_false(b=nil, msg=nil)
      assert_boolean b, msg
      assert !b, msg
    end
    
    def assert_nil(x=1, msg=nil)
      assert x.nil?, msg
    end
    
    def assert_not_nil(x=nil, msg=nil)
      assert !x.nil?, msg
    end
    
    def assert_equal(a, b, msg=nil)
      assert a == b, msg_stack(msg, "#{b} found, expected #{a}")
    end
    
    def assert_not_equal(a, b, msg=nil)
      assert a != b, msg_stack(msg, "#{b} and #{a} are equal")
    end
    
    def assert_kind_of(k=nil, x=nil, msg=nil)
      assert x.kind_of?(k), msg
    end
    
    def assert_instance_of(k=nil, x=nil, msg=nil)
      assert x.instance_of?(k), msg
    end
    
    def assert_raise(kind=Exception, msg=nil, &blk)
      begin
        yield
      rescue Exception => e
        assert_kind_of kind, e, "Expected #{kind.to_s} but #{e.to_s} was raised instead"
        return true
      end
      assert_fail msg_stack(msg, 'No exception raised.')
    end
  
    def isolate(msg=nil, &blk)
      fork do
        yield
        exit!(47) if Test::CONFIG[:nb_nok] > 0 # propagate failure
      end
      child_pid = Process.wait
      assert_equal 0, $?.exitstatus, msg_stack(msg, "Process in isolation returned #{$?.exitstatus}")
    end
  
  end # class << self
  
end end end