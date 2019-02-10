require 'rails_helper'

RSpec.describe 'adding a project', type: :system do
    it 'allows a user to create a project with tasks' do
    visit new_project_path
    fill_in 'Name', with: 'Project Runaway'
    fill_in 'project[:tasks]', with: "Choose fabric:3\r\nMake it work:5"
    click_on 'Create Project'
    visit projects_path
    @project = Project.find_by(name: 'Project Runaway')
    expect(page).to have_selector("#project_#{@project.id} .name", text: 'Project Runaway')
    expect(page).to have_selector("#project_#{@project.id} .total-size", text: '8')
  end
end
