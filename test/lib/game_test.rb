# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../../lib/game'

class GameTest < Minitest::Test
  def test_it_initializes_game_with_shutdown_false
    game = Game.new
    assert !game.shutdown
  end

  def test_it_appends_player_when_it_does_not_exist
    game = Game.new
    game.connect_client(1)
    assert game.players.count == 1
    assert game.players.first.id == 1
  end

  def test_it_does_not_append_player_when_it_exists
    game = Game.new
    game.connect_client(1)
    game.connect_client(1)
    assert game.players.count == 1
    assert game.players.first.id == 1
  end

  def test_it_updates_the_client_name
    game = Game.new
    game.connect_client(1)
    game.update_client(1, 'Primeiro Jogador')
    assert game.players.first&.name == 'Primeiro Jogador'
  end
end
