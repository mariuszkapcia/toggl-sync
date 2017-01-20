#!/usr/bin/env ruby
# encoding: UTF-8

$: << File.join(File.dirname(__FILE__), "../lib")
$: << File.join(File.dirname(__FILE__), "../ext")

require 'oj'

class A < BasicObject
  def initialize(data)
    @data = data
  end
end

a = A.new("xyz")

json = Oj.dump(a, mode: :compat, use_to_json: true)
#=> NoMethodError: undefined method `to_hash' for #<A:0x007fae03de1dc8>

