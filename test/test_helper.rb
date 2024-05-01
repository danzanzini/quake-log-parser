# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/test/' # Exclude test directory from coverage
end
require 'minitest/autorun'
require_relative '../lib/game'
require_relative '../lib/entry'
