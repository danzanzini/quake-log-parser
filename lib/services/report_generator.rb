# frozen_string_literal: true

class ReportGenerator
  def initialize(game)
    @game = game
  end

  def game_report
    {
      total_kills: @game.kills.count,
      players: @game.players.map(&:name),
      kills: pretty_kills_report,
      kills_by_mean: kills_by_mean_report
    }
  end

  def pretty_kills_report
    report = kills_report
    @game.players.each do |player|
      report[player.name] = report.delete player.id
    end
    report
  end

  def kills_report
    report = {}
    @game.kills.each do |kill|
      if kill.world_kill? || kill.self_kill?
        report[kill.killed_id] = (report[kill.killed_id] || 0) - 1
      else
        report[kill.killer_id] = (report[kill.killer_id] || 0) + 1
      end
    end
    report
  end

  def kills_by_mean_report
    report = {}
    @game.kills.each do |kill|
      report[kill.mod] = (report[kill.mod] || 0) + 1
    end
    report
  end
end
