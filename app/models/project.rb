class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  def done?
    tasks.all?(&:complete?)
  end
end
