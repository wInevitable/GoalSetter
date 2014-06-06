require 'rails_helper'
require 'spec_helper'

feature "the authentication process" do
  
  before(:each) do
    sign_up('testing_username')
  end
      
  scenario "has a new user page" do 
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do
    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "testing_username"
    end
  end
  
  feature "logging in" do 
    before(:each) do
      sign_in('testing_username')
    end

    it "shows username on the homepage after login" do
      expect(page).to have_content "testing_username"
    end
    
    feature "logging out" do 
      before(:each) do
        visit new_session_url 
      end

      it "doesn't show username on the homepage after logout" do
        click_button "Sign Out"
        expect(page).to_not have_content "testing_username"
      end
    end
  end
end




