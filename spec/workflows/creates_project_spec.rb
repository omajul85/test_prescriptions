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

    describe 'with a single string' do
      let(:task_string) { 'Clean the house' }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(
              title: 'Clean the house', size: 1) }
    end

    describe 'with a single string with size' do
      let(:task_string) { 'Clean the house:3' }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(
              title: 'Clean the house', size: 3) }
    end

    describe 'with a single string with size 0' do
      let(:task_string) { 'Clean the house:0' }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(
              title: 'Clean the house', size: 1) }
    end

    describe 'with a single string with negative size' do
      let(:task_string) { 'Clean the house:-3' }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(
              title: 'Clean the house', size: 1) }
    end

    describe 'with a single string with malformed size' do
      let(:task_string) { 'Clean the house:' }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.first).to have_attributes(
              title: 'Clean the house', size: 1) }
    end

    describe 'with a string with multiple tasks' do
      let(:task_string) { "Clean the house:2\r\nWalk the dog\r\nAnother:5" }
      specify { expect(tasks.size).to eq(3) }
      specify { expect(tasks).to match(
        [an_object_having_attributes(title: 'Clean the house', size: 2),
         an_object_having_attributes(title: 'Walk the dog', size: 1),
         an_object_having_attributes(title: 'Another', size:5)]) }
    end

    describe 'attaches tasks to the project' do
      let(:task_string) { "Clean the house:2\r\nWalk the dog" }
      before(:example) { creator.create }
      specify { expect(creator.project.tasks.size).to eq(2)}
      specify { expect(creator.project).not_to be_a_new_record }
    end

    describe 'failure cases' do
      it 'fails when trying to create a project with no name' do
        creator = CreatesProject.new(name: '', task_string: '')
        creator.create
        expect(creator).not_to be_a_success
      end
    end
  end
end
