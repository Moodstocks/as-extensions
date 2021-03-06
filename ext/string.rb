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

String.class_eval do

  class << self

    # Load a string from a file or a URL.
    def from(file_or_url)
      ASE::String::from(file_or_url)
    end

    # Return an alphanumeric string.
    def rand_alphanum(n=1, secure=false)
      @ase_alphanum ||= [('a'..'z'), ('A'..'Z'), ('0'..'9')].map{ |x| x.to_a }.flatten
      Array.new(n){ @ase_alphanum.pick(secure) }.join
    end

    # Return an hexadecimal string.
    def rand_hex(n=1, secure=false)
      @ase_hex ||= "0123456789abcdef".chars
      Array.new(n){ @ase_hex.pick(secure) }.join
    end

  end # class << self

  alias :camelcase_noase :camelcase
  # Same as camelcase from ActiveSupport
  # but dashes are considered as underscores.
  def camelcase
    underscore.camelcase_noase
  end

  alias :dasherize_noase :dasherize
  # Same as underscore from ActiveSupport
  # with dashes instead of underscores.
  def dasherize
    underscore.dasherize_noase
  end

  # Consider the String as an Array of chars for a few methods

  def first
    self[0]
  end

  def first=(x)
    raise IndexError, 'empty string' if empty?
    self[0] = x
  end

  alias :head :first
  alias :head= :first=

  def init
    self[0..-2]
  end

  def init=(x)
    self[0..-2] = x
  end

  def last
    self[-1]
  end

  def last=(x)
    raise IndexError, 'empty string' if empty?
    self[-1] = x
  end

  def tail
    self[1..-1]
  end

  def tail=(x)
    self[1..-1] = x
  end

  # Helper to convert a raw string to a sane identifier with dashes and ASCII letters.
  # Interpolation is here to force String type, to_s won't always work.
  def sanitize_dashes
    "#{self.to_slug.approximate_ascii.to_ascii.normalize.to_s}"
  end

  # Sometimes calling puts as a method can be useful
  def puts
    Kernel::puts self
  end
  alias :p :puts

end
