require 'rails_helper'
require 'spec_helper'

feature 'goals' do
  before(:each) do
    sign_up('user')
  end

  feature 'creating a new goal' do
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
  
  feature 'completing a goal' do
    before(:each) do
      create_goal('sample goal')
    end
    
    it 'should be able to complete goal' do
      click_button 'complete goal'
      expect(page).to have_content('sample goal completed')
    end
  end
  
  feature 'other user viewers' do
    before(:each) do
      create_goal('sample goal')
      create_goal('private goal', true)
      click_button 'Sign Out'
      visit user_url(1)
    end
    
    it 'should not see private goals' do
      expect(page).not_to have_content('private goal')
    end
    
    it 'should not have a complete goal button' do
      expect(page).not_to have_button('complete goal')
    end
    
    it 'should have public goals' do
      expect(page).to have_content('sample goal')
    end
    
    it 'should not be able to edit a goal' do
      visit edit_goal_url(1)
      expect(page).to have_content('Sign In')
    end
    
    it 'should not be able to delete a goal' do
      expect(page).not_to have_button('delete goal')
    end
  end
  
  feature 'edit a goal' do
    before(:each) do
      create_goal('sample goal')
    end
    
    it 'should be editable' do
      click_link('edit goal')
      expect(page).to have_content('Edit Goal')
    end
    
    it 'should update goal' do
      click_link('edit goal')
      fill_in 'goal', :with => 'updated goal'
      click_button 'Update Goal'
      expect(page).to have_content('updated goal')
    end
  end
  
  feature 'destroy a goal' do
    before(:each) do
      create_goal('sample goal')
    end
    
    it 'should be able to delete goals' do
      click_button('delete goal')
      expect(page).not_to have_content('sample goal')
    end
  end
end