#!/usr/bin/env ruby

require 'rubygems'
require 'bacon'

require File.expand_path("#{File.dirname(__FILE__)}/../lib/mtrc")

Bacon.summary_on_exit

describe Mtrc::Rate do
  before do
    @r = Mtrc::Rate.new
  end

  rates = (-2..6).map { |r| 10 ** r }.reverse
  periods = (-2..1).map { |r| 10 ** r }

  rates.each do |rate|
    periods.each do |period|
      should "count #{rate}/sec over #{period} seconds" do
        t = Thread.new do
          sleep period
          ((@r.rate - rate) / rate).should < 0.001
        end
        
        count = rate * period
        if count < 1
          @r.tick count
        else
          count.to_i.times do
            @r.tick
          end
        end
        
        t.join
      end
    end
  end
end
