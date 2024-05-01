# frozen_string_literal: true

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

  class Player
    attr_reader :id
    attr_accessor :name

    def initialize(id)
      @id = id
      @name = nil
    end
  end

  class Kill
    attr_reader :killer_id, :killed_id, :mod

    def world_kill?
      killer_id == 1022
    end

    def self_kill?
      killer_id == killed_id
    end

    def initialize(kill_info)
      @killer_id = kill_info[:killer_id]
      @killed_id = kill_info[:killed_id]
      @mod = kill_info[:mod]
    end
  end
end
