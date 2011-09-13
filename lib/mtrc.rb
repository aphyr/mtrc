module Mtrc
  # A compact, general system for metric analysis. Minimal code, minimal
  # dependencies.

  $LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))

  require 'mtrc/version'
  require 'mtrc/sample'
  require 'mtrc/samples'
  require 'mtrc/sorted_samples'
  require 'mtrc/rate'
end
