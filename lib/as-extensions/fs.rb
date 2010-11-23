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

module ASE
  
  class << self
  
    # Make sure a directory exists;
    # create it if it is not the case.
    def ensure_dir_exists(dir)
      dir = File.expand_path(dir)
      FileUtils.mkdir_p dir unless File.exist?(dir)
      dir
    end
    
    # Return the first file that exists in a list of files
    def select_file(*files)
      files.each do |file|
        if File.exists?(file) then return file end
      end
      return nil
    end
  
  end # class << self 
  
end
