class Goal < ActiveRecord::Base
  validates :goal, :user_id, presence: true
  validates :secret, :completed, inclusion: { :in => [true, false] }

  before_validation do
    self.completed = false if completed.nil?
    self.secret = false if secret.nil?
  end
  
  belongs_to :user
  #has_many :comments
end
