# frozen_string_literal: true

require 'active_support/inflector'

# The `Game` class represents a single game in the Quake game log.
# It keeps track of game-related information, such as connected players and kills.
class Entry
  # TODO: Use types to define cases at main.rb
  TYPES = %i[client_begin client_connect client_userinfo_changed kill init_game].freeze

  def initialize(log_line)
    @log_line = log_line
    @log_array = log_line.split
  end

  def type
    @type ||= @log_array[1].gsub(':', '').underscore.to_sym
  end

  def client_id
    @client_id ||= %i[client_begin client_connect client_userinfo_changed].include?(type) ? @log_array[2].to_i : nil
  end

  def client_name
    @client_name ||= @log_line.split('n\\').last.split('\\t').first if type == :client_userinfo_changed
  end

  def kill_info
    return if type != :kill

    @kill_info ||= { killer_id: @log_array[2].to_i,
                     killed_id: @log_array[3].to_i,
                     mod: @log_array.last }
  end
end
