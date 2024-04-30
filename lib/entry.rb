# frozen_string_literal: true
class Entry
  attr_accessor :type
  def initialize(log_line)
    @log_line = log_line
  end

  def type
    @type ||= @log_line.split[1].gsub(':', '').underscore.to_sym
  end
end
