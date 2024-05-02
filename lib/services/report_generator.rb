# frozen_string_literal: true

class ReportGenerator
  def initialize(games)
    @games = games
  end

  def games_report
    @games.map do |game|
      {
        total_kills: game.kills.count,
        players: game.players.map(&:name),
        kills: kills_report_with_player_names(game),
        kills_by_mean: kills_by_mean_report(game)
      }
    end
  end

  private

  def kills_report_with_player_names(game)
    report = kills_report(game)
    game.players.each do |player|
      report[player.name] = (report.delete(player.id) || 0)
    end
    report
  end

  def kills_report(game)
    game.kills.each_with_object({}) do |kill, report|
      if kill.world_kill? || kill.self_kill?
        report[kill.killed_id] = (report[kill.killed_id] || 0) - 1
      else
        report[kill.killer_id] = (report[kill.killer_id] || 0) + 1
      end
    end
  end

  def kills_by_mean_report(game)
    game.kills.each_with_object({}) do |kill, report|
      report[kill.mod] = (report[kill.mod] || 0) + 1
    end
  end
end
