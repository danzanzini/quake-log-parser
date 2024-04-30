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
end
