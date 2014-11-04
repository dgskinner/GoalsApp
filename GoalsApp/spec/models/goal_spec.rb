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

require 'rails_helper'

RSpec.describe Goal, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
