require 'rails_helper'
require 'spec_helper'

RSpec.describe User, :type => :model do
  
  context 'without attributes' do
    let(:incomplete_user) { User.new }
    
    it 'validates presence of name' do
      expect(incomplete_user).not_to be_valid
      expect(incomplete_user.errors[:username]).to include("can't be blank")
    end
    
    it 'validates presence of password_digest' do
      expect(incomplete_user).not_to be_valid
      expect(incomplete_user.errors[:password_digest]).to include("can't be blank")
    end
    
    it 'validates presence of password' do
      incomplete_user = User.new(password: 'a')
      expect(incomplete_user).not_to be_valid
      expect(incomplete_user.errors[:password]).to include("must be at least 6 characters")
    end
    
    it 'validates presence of session_token' do
      expect(incomplete_user).not_to be_valid
      expect(incomplete_user.errors[:session_token]).to be_empty
    end
    
    it 'validates uniqueness of username' do
      user1 = User.create!({username: 'aaa', password: '123456'})
      user2 = User.new({username: 'aaa', password: '123456'})
      expect(user2).not_to be_valid
    end
  end
end
