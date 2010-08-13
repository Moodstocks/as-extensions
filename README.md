# ActiveSupport::Extension (as-extensions)

## Purpose

This gem is built on top of ActiveSupport. It provides useful core
extensions, methods and modules.

## Warning

Using this gem will make some classes behave differently than what you
are used to. The Time and DateTime classes are especially concerned.
Read the RDoc if you use them.

## How To Install

1. Install Jeweler (http://github.com/technicalpickles/jeweler).
2. Clone the Git repository
3. Run:
        rake build
        gem install pkg/*.gem
4. Add "require 'as-extensions'" to your code.

## Copyright

Copyright (c) 2010 Moodstocks SAS
