require 'minitest/autorun'

require_relative '../../lib/game'

class GameTest < Minitest::Test
  def test_it_initializes_game_with_shutdown_false
    @game = Game.new
    assert !@game.shutdown
  end
end
