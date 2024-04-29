require_relative 'entry'

# TODO: Add option to receive from input
filename = "./resources/quake_logs.txt"

@games = []

File.open(filename, 'r') do |f|
  f.each_line do |log_line|
    log_entry = Entry.new(log_line)

    case log_entry.type
    when :init_game
      start_game
    when :kill
      game.add_kill_from_entry(entry)
    when :shutdown_game
      game.shutdown
    else line_not_used
    end
  end
end

def start_game
  @games.append(Game.new)
end

# Split line
# [0] -> time
# [1] -> Type [Kill, InitGame, ShutdownGame]

# If Kill
# Pra cada tipo, um split diferente
