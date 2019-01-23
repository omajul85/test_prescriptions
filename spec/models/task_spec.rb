require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { Task.new }

  it 'does not have a new task as complete' do
    expect(task).not_to be_complete
  end

  describe 'velocity' do
    let(:task) { Task.new(size: 3) }

    it 'does not count an incomplete task towards velocity' do
      expect(task).not_to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(0)
    end

    it 'counts a recently complete task towards velocity' do
      task.mark_completed(date: 1.day.ago)
      expect(task).to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(3)
    end

    it 'does not count a long-ago completed task towards velocity' do
      task.mark_completed(date: 5.weeks.ago)
      expect(task).not_to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(0)
    end
  end
end
