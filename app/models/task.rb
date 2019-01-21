class Task < ApplicationRecord
  belongs_to :project

  @completed = false

  def mark_completed
    @completed = true
  end

  def complete?
    @completed
  end
end
