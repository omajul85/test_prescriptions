require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'without a task' do
    let(:project) { build_stubbed(:project) }

    it 'considers a project with no tasks as done' do
      expect(project).to be_done
    end

    it 'properly handles a blank project' do
      expect(project.completed_velocity).to eq(0)
      expect(project.current_rate).to eq(0)
      expect(project.projected_days_remaining).to be_nan
      expect(project).not_to be_on_schedule
    end
  end

  describe 'with a task' do
    let(:project) { build_stubbed(:project, tasks: [task]) }
    let(:task) { build_stubbed(:task) }

    it 'knows that a project with incomplete tasks is not done' do
      expect(project).not_to be_done
    end

    it 'considers a project done if its tasks are done' do
      task.mark_completed
      expect(project).to be_done
    end
  end

  describe 'estimates' do
    let(:project) { build_stubbed(:project, tasks: [newly_done, old_done, small_not_done, large_not_done]) }
    let(:newly_done) { build_stubbed(:task, :newly_complete) }
    let(:old_done) { build_stubbed(:task, :long_complete) }
    let(:small_not_done) { build_stubbed(:task, :small) }
    let(:large_not_done) { build_stubbed(:task, :large) }

    it 'calculates total size' do
      expect(project.total_size).to eq(12)
    end

    it 'calculates remaining size' do
      expect(project.remaining_size).to eq(6)
    end

    it 'knows its velocity' do
      expect(project.completed_velocity).to eq(3)
    end

    it 'knows its rate' do
      expect(project.current_rate).to eq(3.0 / Project.velocity_length_in_days)
    end

    it 'knows its projected days remaining' do
      expect(project.projected_days_remaining).to eq(42)
    end

    it 'knows if it is not on schedule' do
      project.due_date = 1.week.from_now
      expect(project).not_to be_on_schedule
    end

    it 'knows if it is on schedule' do
      project.due_date = 6.months.from_now
      expect(project).to be_on_schedule
    end
  end

  describe 'task order' do
    let(:project) { create(:project, name: 'Project') }

    it 'makes the order of the first task in an entry project' do
      expect(project.next_task_order).to eq(1)
    end

    it 'makes the order of the next task one more than the highest' do
      project.tasks.create(project_order: 1)
      project.tasks.create(project_order: 2)
      project.tasks.create(project_order: 3)
      expect(project.next_task_order).to eq(4)
    end
  end
end
