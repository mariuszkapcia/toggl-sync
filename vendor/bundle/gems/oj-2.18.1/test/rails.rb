#!/usr/bin/env ruby
# encoding: UTF-8

$VERBOSE = true

here = File.expand_path(File.dirname(__FILE__))
$: << File.dirname(__FILE__)
$: << File.join(File.dirname(here), 'ext')
$: << File.join(File.dirname(here), 'lib')

require "active_record"
require "minitest/autorun"
require "logger"
require 'sidekiq/testing'
require "rspec/mocks/minitest_integration"
require 'oj'

Oj.mimic_JSON

Sidekiq::Testing.inline!

# Ensure backward compatibility with Minitest 4
Minitest::Test = MiniTest::Unit::TestCase unless defined?(Minitest::Test)

# This connection will do for database-independent bug reports.
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :posts, force: true do |t|
  end
end

class Post < ActiveRecord::Base
end

class MyWorker
  include Sidekiq::Worker

  def perform(post)
  end
end

class BugTest < Minitest::Test
  def test_as_json
    Post.arel_table
    dbl = instance_double("Post", id: 1)
    MyWorker.perform_async dbl
  end
end
