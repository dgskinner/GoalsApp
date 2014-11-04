# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :text             not null
#  privacy     :string(255)      not null
#  status      :string(255)      not null
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Goal < ActiveRecord::Base
  validates :title, :description, :privacy, :status, :user, presence: true
  
  belongs_to :user
  
  def is_private?
    self.privacy == "Private"
  end
end
