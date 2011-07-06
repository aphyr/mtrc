#!/usr/bin/env ruby

require 'rubygems'
require 'bacon'

require File.expand_path("#{File.dirname(__FILE__)}/../lib/mtrc")

Bacon.summary_on_exit

describe Mtrc::SortedSamples do
  # Returns a nonzero float with decaying exponential probability.
  def float(min = 0.1, max = 100)
    min = Math.log min
    max = Math.log max
    scale = max - min

    Math::E ** ((rand * scale) + min)
  end

  def int(*a)
    float(*a).floor
  end
  
  def dataset
    min = int
    max = min + int
    
    (min..max).map do |n|
      [n] * int(0.7, 10)
    end.flatten
  end

  it 'works' do
    1000.times do
      p = Mtrc::SortedSamples.new
      d = dataset

      # Insert
      d.shuffle.each do |n|
        p.add n
        p.ns.sort.should == p.ns
      end

      # Verify
      d.should == p.ns
      d.each_with_index do |n, i|
        n1 = p.at(i.to_f / d.size)
        n1.should == n
      end
    end
  end

  it 'fast' do
    items = (0...100000).each do
      int
    end

    p = Mtrc::SortedSamples.new
    t1 = Time.now
    items.each do |item|
      p << item
    end
    t2 = Time.now
    (t2-t1).should < 0.1
  end
end
