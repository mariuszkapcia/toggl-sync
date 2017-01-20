#!/usr/bin/env ruby
# encoding: UTF-8

$VERBOSE = true

%w(lib ext test).each do |dir|
  $LOAD_PATH.unshift File.expand_path("../../#{dir}", __FILE__)
end

require 'sqlite3'
require 'active_record'
require 'oj'
require 'representable'
require 'representable/json'
require 'multi_json'
MultiJson.use(:oj)
Oj.default_options = {mode: :object, indent: 2}

#ActiveRecord::Base.logger = Logger.new(STDERR)

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => ":memory:"
)

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "picture"
    t.integer  "state",                              null: false
    t.integer  "visible",            default: 1,     null: false
    t.integer  "role",                               null: false
    t.string   "position"
    t.integer  "responded",          default: 0
    t.string   "slug"
  end
end

class User < ActiveRecord::Base
end
User.find_or_create_by(first_name: "John", last_name: "Smith",role:1,id:1,state: 0)
User.find_or_create_by(first_name: "John", last_name: "Smith",role:1,id:2,state: 0)


class PersonDecorator < Representable::Decorator
  include Representable::JSON
  include Representable::Hash

  property :id

  property :first_name

  property :last_name,
           default: nil

  property :name,
           getter: ->(_){ "#{first_name} #{last_name}".strip },
           writeable: false

  property :visible,
           render_filter: lambda{ |value, _| !value.zero? },
           parse_filter: lambda{ |value, _| value ? 1 : 0 },
           default: 1

  property :role,
           render_filter: lambda{ |value, _| { 1 => 'staff', 2 => 'manager' }[value].to_s },
           writeable: false

  property :position

  nested :image, skip_render: lambda{ |options| options[:represented].picture.nil? } do
    property :picture, as: :url, writeable: false
  end

end

class PersonViewModel

  def initialize(person, organization)
    @users = User.all
    @person = person
    @organization = organization
  end

  def to_json(options={})
    PersonDecorator.represent(@users.to_a)
  end

  def json_with_decorator(options={})
    PersonDecorator.new(person).to_json
  end

  def person
    @person
  end
end

class EmployeeViewModel < PersonViewModel

end

employee = User.find(1)
emp_json = EmployeeViewModel.new(employee,nil)
puts emp_json.to_json.to_json
puts emp_json.json_with_decorator
Oj.mimic_JSON
# when i use Oj.mimic_JSON script crash
# when i dont use Oj.mimic_JSON then dont use correct decorator
puts Oj.dump(emp_json)
puts Oj.dump(emp_json.to_json)
