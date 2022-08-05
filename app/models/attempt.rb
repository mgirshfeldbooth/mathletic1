# == Schema Information
#
# Table name: attempts
#
#  id          :integer          not null, primary key
#  correct     :boolean
#  finished_at :datetime
#  started_at  :datetime
#  submission  :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  exercise_id :integer
#  round_id    :integer
#  user_id     :integer
#
class Attempt < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  belongs_to(:exercise, { :required => true, :class_name => "Exercise", :foreign_key => "exercise_id" })
  belongs_to(:round, { :required => true, :class_name => "Round", :foreign_key => "round_id", :counter_cache => true })
end
