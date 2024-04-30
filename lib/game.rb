# frozen_string_literal: true

class Game
  attr_reader :shutdown, :players

  def initialize
    @shutdown = false
    @players = []
  end

  def connect_client(client_id)
    @players.append(Player.new(client_id)) if @players.none? { |p| p.id == client_id }
  end

  def update_client(client_id, name)
    client = @players.find { |p| p.id == client_id }
    client&.name = name
  end

  class Player
    attr_reader :id
    attr_accessor :name

    def initialize(id)
      @id = id
      @name = nil
    end
  end
end
