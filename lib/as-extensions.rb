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

# Force KCODE to UTF-8, a sane default
$KCODE = "U" if (RUBY_VERSION < "1.9") && ($KCODE == "NONE")

module ASE

  class << self

    # Require a part / parts of a library
    def require_part(part,dir=nil)
      orig = caller(1).first.split(':').first
      dir ||= File.join(File.dirname(orig),File.basename(orig,".rb"))
      if part.is_a?(::Array)
        part.each{|p| require_part(p,dir)}
      else
        require File.join(dir,part)
      end
    end

    # Require an extension / extensions of a library
    def require_ext(ext,dir=nil)
      orig = caller(1).first.split(':').first
      dir ||= File.join( File.dirname(File.dirname(orig)),"ext")
      if ext.is_a?(::Array)
        ext.each{|e| require_ext(e,dir)}
      else
        require File.join(dir,ext)
      end
    end

  end # class << self

  # This loading order (extra-ext, need, logger, log)
  # is necessary to bootstrap need()
  require_part %w{extra-ext need}
  need "logger"
  require_part "log"

  # Now we can load everything normally
  need %w{active_support babosa base64 fileutils map open-uri pathname uri
           set socket}
  need %w{active_support/core_ext}
  require_part %w{fs enum deep net test time ext-logic}
  require_ext %w{array base64 datetime dir enumerable file hash io object set
                  socket string symbol time uri}

end

"x".to_json # define String#as_json, cf. https://gist.github.com/1677748

unless ActiveSupport::const_defined?("Extension")
  ActiveSupport::const_set("Extension",ASE)
end
