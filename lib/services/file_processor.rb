# frozen_string_literal: true

require_relative '../classes/entry'
require_relative '../classes/game'

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
