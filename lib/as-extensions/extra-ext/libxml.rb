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

# Patch the LibXML::XML::Reader class to add useful methods.

::LibXML::XML::Reader.class_eval do
  
  # Test if the Reader is at the beginning of a tag.
  # If a string argument is passed, it has to be the name of the tag.
  def at_start?(tag  = nil)
    ( (self.node_type == self.class::TYPE_ELEMENT) &&
      [self.name, nil].include?(tag) )
  end
  
  # Test if the Reader is at the end of a tag.
  # If a string argument is passed, it has to be the name of the tag.
  def at_end?(tag = nil)
    ( (self.node_type == self.class::TYPE_END_ELEMENT) &&
      [self.name, nil].include?(tag) )
  end
  
  # Test if the Reader is at a whitespace text element.
  def at_whitespace?()
    [ self.class::TYPE_WHITESPACE,
      self.class::TYPE_SIGNIFICANT_WHITESPACE ].include?(self.node_type)
  end
  
  # Test if the Reader is at a non-whitespace text element.
  def at_text?()
    [ self.class::TYPE_TEXT,
      self.class::TYPE_CDATA ].include?(self.node_type)
  end
  
  # Move the Reader to the next text element and return its value.
  def get_text!(tag_only = false, mover_symbol = :read)
    mover = self.method(mover_symbol)
    loop do
      if tag_only && self.at_end? then return nil
      elsif self.at_text? then return self.value.strip
      elsif mover.call == 0 then return nil end
    end
  end
  
end
