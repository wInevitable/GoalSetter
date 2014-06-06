require 'rails_helper'
require 'spec_helper'

feature 'goals' do
  before(:each) do
    sign_up('user')
  end

  scenario 'creating a new goal' do
    before(:each) do
      visit new_goal_url
    end
    
    it 'should have proper labelling' do
      expect(page).to have_content('New Goal')
    end
    
    it 'creates a goal' do
      create_goal('sample goal')
      expect(page).to have_content('sample goal')
      expect(page).to have_button('complete goal')
    end
  end
  
  scenario 'completing a goal' do
    before(:each) do
      create_goal('sample goal')
    end
    
    it 'should be able to complete goal' do
      click_button 'complete goal'
      expect(page).to have_content('sample goal completed')
    end
  end
  
  scenario 'other user viewers' do
    before(:each) do
      create_goal('sample goal')
      create_goal('private goal', true)
      click_button 'Sign Out'
      visit user_url(1)
    end
    
    it 'should not see private goals' do
      expect(page).not_to have_content('private goal')
    end
  end
end