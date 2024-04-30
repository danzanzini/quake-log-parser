class Game
  attr_reader :shutdown, :players
  def initialize
    @shutdown = false
    @players = []
  end

  def connect_client(client_id)
    @players.append(Player.new(client_id)) if @players.none? { |p| p.id == client_id }
  end

  class Player
    attr_reader :id
    def initialize(id)
      @id = id
    end
  end
end
