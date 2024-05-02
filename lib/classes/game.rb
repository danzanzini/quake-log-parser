# frozen_string_literal: true

# Represents a single game in the Quake game log.
# It keeps track of game-related information, such as connected players and kills.
class Game
  attr_reader :shutdown, :players, :kills

  def initialize
    @shutdown = false
    @players = []
    @kills = []
  end

  def connect_client(client_id)
    @players.append(Player.new(client_id)) if @players.none? { |p| p.id == client_id }
  end

  def update_client(client_id, name)
    client = @players.find { |p| p.id == client_id }
    client&.name = name
  end

  def add_kill(kill_info)
    @kills.append(Kill.new(kill_info))
  end

  # Represents a client in the Quake game. It stores it's ID and current name
  class Player
    attr_reader :id
    attr_accessor :name

    def initialize(id)
      @id = id
      @name = nil
    end
  end

  # Represents a kill event in the Quake game.
  # It stores information about the killer, the victim, and the means of death (MOD).
  # The class provides methods to determine if the kill was a suicide or a world kill.
  class Kill
    attr_reader :killer_id, :killed_id, :mod

    def initialize(kill_info)
      @killer_id = kill_info[:killer_id]
      @killed_id = kill_info[:killed_id]
      @mod = kill_info[:mod]
    end

    def world_kill?
      killer_id == 1022
    end

    def self_kill?
      killer_id == killed_id
    end
  end
end
