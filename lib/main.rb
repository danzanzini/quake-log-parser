# frozen_string_literal: true

require 'bundler/setup'

require_relative 'entry'
require_relative 'game'

# TODO: Add option to receive from input
filename = './resources/quake_logs.txt'

@games = []
def start_game
  @games.append(Game.new)
end

def current_game
  @games.last
end

File.open(filename, 'r') do |f|
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
    when :shutdown_game
      current_game.shutdown
      else nil
    end
  end
end

pp @games.count

# Split line
# [0] -> time
# [1] -> Type [Kill, InitGame, ShutdownGame]

# If Kill
# Pra cada tipo, um split diferente
