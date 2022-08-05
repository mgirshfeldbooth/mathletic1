# == Schema Information
#
# Table name: exercises
#
#  id         :integer          not null, primary key
#  answer     :float
#  difficulty :integer
#  question   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Exercise < ApplicationRecord
  has_many(:attempts, { :class_name => "Attempt", :foreign_key => "exercise_id", :dependent => :destroy })
end
