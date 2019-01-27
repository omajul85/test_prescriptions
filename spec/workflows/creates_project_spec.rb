require 'rails_helper'

RSpec.describe CreatesProject do
  let(:creator) { CreatesProject.new(name: 'Project Runaway', task_string: task_string) }

  describe 'initialization' do
    let(:task_string) { '' }
    it 'creates a project given a name' do
      creator.build
      expect(creator.project.name).to eq('Project Runaway')
    end
  end

  describe 'task String parsing' do
    let(:tasks) { creator.convert_string_to_tasks }

    describe 'with an empty string' do
      let(:task_string) { '' }
      specify { expect(tasks).to be_empty }
    end
  end
end
