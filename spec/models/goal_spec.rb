require 'rails_helper'

RSpec.describe Goal, :type => :model do
  context 'without attributes' do
    let(:incomplete_goal) { Goal.new }
    
    it 'validates the presence of goal' do
      expect(incomplete_goal.errors[:goal]).to include("can't be blank")
    end
    
    it 'validates the presence of user_id' do
      expect(incomplete_goal.errors[:user_id]).to include("can't be blank")
    end
  end
end
