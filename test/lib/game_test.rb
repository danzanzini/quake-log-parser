# frozen_string_literal: true

require_relative '../test_helper'

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

  def test_it_adds_a_kill
    game = Game.new
    game.add_kill(killer_id: 1, killed_id: 2, mod: 3)
    assert game.kills.count == 1

    kill = game.kills.first
    assert kill&.killer_id == 1
    assert kill&.killed_id == 2
    assert kill&.mod == 3
  end

  class KillTest < Minitest::Test
    def setup
      @kill_info = { killer_id: 1, killed_id: 2, mod: 'MOD_RAILGUN' }
      @kill = Game::Kill.new(@kill_info)
    end

    def test_initialize
      assert_equal 1, @kill.killer_id
      assert_equal 2, @kill.killed_id
      assert_equal 'MOD_RAILGUN', @kill.mod
    end

    def test_world_kill?
      refute @kill.world_kill?

      @kill_info[:killer_id] = 1022
      world_kill = Game::Kill.new(@kill_info)
      assert world_kill.world_kill?
    end

    def test_self_kill?
      refute @kill.self_kill?

      @kill_info[:killer_id] = 2
      self_kill = Game::Kill.new(@kill_info)
      assert self_kill.self_kill?
    end
  end
end
