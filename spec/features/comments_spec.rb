require 'rails_helper'
require 'spec_helper'

feature 'comments' do
  
  before(:each) do
    sign_up('goal_setter')
    create_goal('first_goal')
    create_goal('private_goal', true)
  end
  
  feature 'comment on a goal' do
    
    scenario 'comments on own goal' do
      comment('good job', 'first_goal')
      expect(page).to have_content('good job')
    end
    
    scenario 'comments on other goal' do
      sign_up('fan')
      visit user_url(1)
      comment('u r the werst', 'first_goal')
      expect(page).to have_content('u r the werst')
    end
  end
  
  feature 'comment on a user' do
    scenario 'comments on own goal' do
      comment('good job')
      expect(page).to have_content('good job')
    end
    
    scenario 'comments on other goal' do
      sign_up('fan')
      visit user_url(1)
      comment('u r the werst')
      expect(page).to have_content('u r the werst')
    end
  end
  
  feature 'must be signed in to comment' do
    click_button('Sign Out')
    visit user_url(1)
    expect(page).not_to have_button('submit comment')
  end
  
  feature 'cannot comment on a private goal' do
    sign_up('fan')
    visit user_url(1)
    expect(page).not_to have_link('private goal')
  end
end