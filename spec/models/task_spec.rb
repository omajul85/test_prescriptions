require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { Task.new }

  it 'does not have a new task as complete' do
    expect(task).not_to be_complete
  end
end
