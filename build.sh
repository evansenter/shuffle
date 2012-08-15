#!/bin/sh
gem uninstall shuffle --ignore-dependencies
gem build shuffle.gemspec && gem install shuffle --no-rdoc --no-ri --ignore-dependencies && ruby -e "require 'shuffle'"
