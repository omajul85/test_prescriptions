require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { Project.new }
  let(:task) { Task.new }

  it 'considers a project with no tasks as done' do
    expect(project).to be_done
  end

  it 'knows that a project with incomplete tasks is not done' do
    project.tasks << task
    expect(project).not_to be_done
  end

  it 'considers a project done if its tasks are done' do
    task.mark_completed
    project.tasks << task
    expect(project).to be_done
  end

  describe 'estimates' do
    let(:project) { Project.new }
    let(:newly_done) { Task.new(size: 3, completed_at: 2.days.ago) }
    let(:old_done) { Task.new(size: 2, completed_at: 3.months.ago) }
    let(:small_not_done) { Task.new(size: 1) }
    let(:large_not_done) { Task.new(size: 4) }

    before(:example) do
      project.tasks = [newly_done, old_done, small_not_done, large_not_done]
    end

    it 'calculates total size' do
      expect(project.total_size).to eq(10)
    end

    it 'calculates remaining size' do
      expect(project.remaining_size).to eq(5)
    end
  end
end
