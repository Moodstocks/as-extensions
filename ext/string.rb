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

String.class_eval do
  
  class << self
    
    # Load a string from a file or a URL.
    def from(file_or_url)
      ActiveSupport::Extension::String::from(file_or_url)
    end
    
    # Return an alphanumeric string.
    def rand_alphanum(n=1)
      @as_alphanum ||= [('a'..'z'), ('A'..'Z'), ('0'..'9')].map{ |x| x.to_a }.flatten
      Array.new(n){ @as_alphanum.pick }.join
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
  
  # Helper to convert a raw string to a sane identifier with dashes and ASCII letters.
  # Interpolation is here to force String type, to_s won't always work.
  String.class_eval do
    def sanitize_dashes
      "#{ActiveSupport::Extension::SlugString.new(self).approximate_ascii.to_ascii.normalize.to_s}"
    end
  end
  
end
