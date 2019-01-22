class Task #< ApplicationRecord
  # belongs_to :project
  attr_accessor :size, :completed

  def initialize(opts = {})
    @size = opts[:size]
    @completed = opts[:completed]
  end

  def mark_completed
    @completed = true
  end

  def complete?
    @completed
  end
end
