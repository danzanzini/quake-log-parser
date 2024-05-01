# frozen_string_literal: true

require 'bundler/setup'

require_relative 'services/file_processor'
require_relative 'services/report_generator'

LOG_FILE = './resources/quake_logs.txt'

def print_report(report)
  puts "Total games: #{report.count}"
  report.each_with_index do |game_report, idx|
    pp "game#{idx + 1}": game_report
  end
end

games = FileProcessor.new(LOG_FILE).process
report = ReportGenerator.new(games).games_report
print_report(report)
