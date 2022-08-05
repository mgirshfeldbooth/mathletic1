# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  attempts_count  :integer
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:rounds, { :class_name => "Round", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:attempts, { :class_name => "Attempt", :foreign_key => "user_id", :dependent => :destroy })
end
