# frozen_string_literal: true

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
    @kill_info ||= { killer: @log_array[2].to_i, killed: @log_array[3].to_i, mod: @log_array[4].to_i } if type == :kill
  end
end
