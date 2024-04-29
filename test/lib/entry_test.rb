require 'minitest/autorun'
require_relative '../../lib/entry'

class EntryTest < Minitest::Test
  def test_it_gets_the_correct_type_from_log
    @entry = Entry.new('21:07 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT')
    assert @entry.type == :kill
  end
end
