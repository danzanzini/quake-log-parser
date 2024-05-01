# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/test/' # Exclude test directory from coverage
end
require 'minitest/autorun'
require_relative '../lib/classes/game'
require_relative '../lib/classes/entry'
require_relative '../lib/services/report_generator'
