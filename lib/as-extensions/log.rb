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

module ASE
  
  # Initialize logger
  LOGGER = Logger.new(STDERR)
  LOGGER.level = Logger::WARN
  
  class << self
  
    # Print to the logs. Exit if logging a fatal error.
    # Level can be one of: :debug, :info, :warn, :error, :fatal.
    # Returns nil.
    def log(s, level=(:warn))
      LOGGER.send(level, s)
      exit! if level == :fatal
      nil
    end
    
    def log_level=(level=(:warn))
      LOGGER.level = level.is_a?(Symbol) ? Logger.const_get(level.to_s.upcase) : level
    end
  
    # Run a block with logging disabled
    def silently
      old_level = LOGGER.level
      LOGGER.level = Logger::FATAL
      ret = yield
      LOGGER.level = old_level
      ret
    end
  
  end # class << self 
  
end
