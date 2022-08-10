# == Schema Information
#
# Table name: rounds
#
#  id             :integer          not null, primary key
#  attempts_count :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
class Round < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })
  has_many(:attempts, { :class_name => "Attempt", :foreign_key => "round_id", :dependent => :destroy })

  has_many :exercises, :through => :attempts
end
