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

Enumerable.class_eval do
  
  # When a method doesn't exist, convert to an Array
  def method_missing(method_sym, *arguments, &block)
    if !is_a?(Array) && respond_to?(:to_a) then to_a.send(method_sym, *arguments, &block)
    else raise NoMethodError.new("undefined method `#{method}' for #{self.inspect}") end
  end
  
end
