# frozen_string_literal: true

class ReportGeneratorTest < Minitest::Test
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

    comparing_hash = {
      total_kills: 26,
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

    assert ReportGenerator.new(game).game_report == comparing_hash
  end
end
