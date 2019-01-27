require 'rails_helper'

RSpec.describe 'adding a project', type: :system do
    it 'allows a user to create a project with tasks' do
    visit new_project_path
    fill_in 'Name', with: 'Project Runaway'
    fill_in 'project[:tasks]', with: "Choose fabric:3\nMake it work:5"
    click_on 'Create Project'
    visit projects_path
    expect(page).to have_content('Project Runaway')
    expect(page).to have_content(8)
  end
end
