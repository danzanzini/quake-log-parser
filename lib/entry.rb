# frozen_string_literal: true
class Entry
  def initialize(log_line)
    @line_array = log_line.split
  end

  def type
    # TODO: Implement type
    :type
  end
end
