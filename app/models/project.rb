class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  def done?
    tasks.empty?
  end
end
