require 'spec_helper'

feature 'submission' do
  scenario 'submit code for a problem' do
    @problem = Factory.create(:adding_problem)
    @problem_set = Factory.create(:problem_set, :problems => [@problem], :group_ids => [0])
    login_as users(:user), :scope => :user

    visit submit_problem_path(@problem)
    
    expect do
      within '#new_submission' do
        select 'C++', :from => 'submission_language'
        attach_file 'submission_source_file', Rails.root.join('spec/fixtures/files/adding.cpp')
        click_on 'Submit'
      end
    end.to change{users(:user).submissions.count}.by(1)
  end
end