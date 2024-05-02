# frozen_string_literal: true

require_relative '../classes/entry'
require_relative '../classes/game'

# Service responsible for processing the Quake game log file.
# It reads the log file line by line, creates `Entry` objects for each log entry, and updates the corresponding `Game` object based on the entry type.
# TODO: It has many responsibilities. There is room for improvement in this service.
class FileProcessor
  def initialize(filename)
    @filename = filename
    @games = []
  end

  def process
    File.open(@filename, 'r') do |f|
      f.each_line do |log_line|
        entry = Entry.new(log_line)

        case entry.type
        when :init_game
          start_game
        when :client_connect
          current_game.connect_client(entry.client_id)
        when :client_userinfo_changed
          current_game.update_client(entry.client_id, entry.client_name)
        when :kill
          current_game.add_kill(entry.kill_info)
        end
      end
    end

    @games
  end

  private

  def start_game
    @games.append(Game.new)
  end

  def current_game
    @games.last
  end
end
