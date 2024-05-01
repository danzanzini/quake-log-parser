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

  def test_it_generates_a_report
    game = Game.new
    game.connect_client(1)
    game.connect_client(2)
    game.connect_client(3)
    game.connect_client(4)

    game.update_client(1, 'First player')
    game.update_client(2, 'Second player')
    game.update_client(3, 'Third player')
    game.update_client(4, 'Fourth player')
    game.update_client(4, 'Fourth player Reloaded')

    (1..4).each do |killer|
      (1..4).each do |killed|
        game.add_kill(killer_id: killer, killed_id: killed, mod: 'MOD_ROCKET')
      end
      game.add_kill(killer_id: 1022, killed_id: killer, mod: 'MOD_TRIGGER_HURT')
    end

    game.add_kill(killer_id: 2, killed_id: 1, mod: 'MOD_ROCKET_SPLASH')
    game.add_kill(killer_id: 3, killed_id: 2, mod: 'MOD_ROCKET_SPLASH')
    game.add_kill(killer_id: 3, killed_id: 4, mod: 'MOD_ROCKET_SPLASH')
    game.add_kill(killer_id: 4, killed_id: 1, mod: 'MOD_ROCKET_SPLASH')
    game.add_kill(killer_id: 4, killed_id: 2, mod: 'MOD_ROCKET_SPLASH')
    game.add_kill(killer_id: 4, killed_id: 3, mod: 'MOD_ROCKET_SPLASH')

    comparing_hash = { total_kills: 26,
                       players: ['First player', 'Second player', 'Third player', 'Fourth player Reloaded'],
                       kills: {
                         'First player' => 1,
                         'Second player' => 2,
                         'Third player' => 3,
                         'Fourth player Reloaded' => 4
                       },
                       kills_by_mean: {
                         'MOD_ROCKET' => 16,
                         'MOD_TRIGGER_HURT' => 4,
                         'MOD_ROCKET_SPLASH' => 6
                       }
                      }

    assert game.report.to_s == comparing_hash.to_s
  end
end
