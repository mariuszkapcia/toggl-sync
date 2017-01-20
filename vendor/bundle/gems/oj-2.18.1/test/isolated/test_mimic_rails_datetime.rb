#!/usr/bin/env ruby
# encoding: UTF-8

$: << File.join(File.dirname(__FILE__), '..')

require 'helper'
require 'oj/active_support_helper'

class ObjectFolder < Minitest::Test
  def setup
    @default_options = Oj.default_options
  end

  def teardown
    Oj.default_options = @default_options
  end

  def test_as_json
    Oj.mimic_JSON()
    dt = DateTime.now()
    
    json = dt.to_json()

    puts json
  end

end
