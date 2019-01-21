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
end
